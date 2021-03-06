#!/bin/bash

# Mounts EFS volumes configured in "/etc/opt/uiuc-techservices/efs" inside
# "/mnt" based on the name of the file in the configuration directory. Options
# available for each mount:
#
#	efs_filesystem_id: the fs-XXXXXXXX ID to mount. Required.
#	mount_target: where to mount at. Default: /mnt/<config name>
#	nfs_options: options to pass to mount_nfs4. Default: nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2

aws_data () { curl --silent --fail --retry 3 http://169.254.169.254/$1; }

#Get region of EC2 from instance metadata
EC2_AVAIL_ZONE=$(aws_data latest/meta-data/placement/availability-zone)
EC2_REGION=$(echo "$EC2_AVAIL_ZONE" | sed -e 's:\([0-9][0-9]*\)[a-z]*$:\1:')

echo "INFO: Availability Zone = $EC2_AVAIL_ZONE"
echo "INFO: Region = $EC2_REGION"

uiuc_efs_mount () {
  local name=$(basename "$1" ".conf")
  local efs_filesystem_id=''
  local mount_target="/mnt/${name}"
  local nfs_options="nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2"

  . "$1"

  if [[ -z $efs_filesystem_id ]]; then
  	echo "ERROR: ${name} does not have an 'efs_filesystem_id' set"
  	return 1
  fi

  local dir_src="${efs_filesystem_id}.efs.${EC2_REGION}.amazonaws.com"
  local dir_tgt="$mount_target"

  if ! egrep -q "^${dir_src}:/" /etc/fstab; then
  	mkdir -p "${dir_tgt}"
  	if ! mount -t nfs4 -o "${nfs_options}" "${dir_src}:/" "${dir_tgt}"; then
  		echo "ERROR: ${name} mounting ${dir_src} to ${dir_tgt} failed"
  		return 1
  	fi

  	echo -e "${dir_src}:/\t${dir_tgt}\tnfs4\t${nfs_options}\t0\t0" | tee -a /etc/fstab
  fi
}

cp -p /etc/fstab /etc/fstab.bak-efs
for efs_config in /etc/opt/uiuc-techservices/efs/*.conf; do
  [[ -f "$efs_config" ]] || continue
  uiuc_efs_mount "$efs_config"
done
