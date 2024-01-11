_gen_excfile() {
local file=$(cat <<-END
#
# This file contains paths to be excluded from the backup process
# Edit this file to add or remove locations to be skipped
#
# Skip previous backups
${DEST}/${HOSTNAME}_${OS}-full*

# Skip temporary files
/tmp/*

# Skip package manager cache; Replace with the your distro correspondent one
/var/cache/pacman/pkg/
END

)

echo "$file"
}

_gen_conf() {
local file=$(cat <<-END
#
# This file contains values to be used during the backup
# It is advised to avoid editing this file manually;
# In case changes are required, use --genconf parameter to regenerate the file
#
BAK_DIR=${DEST}
EXCLUDE=${EXCFILE}
PC=${HOSTNAME}
DIST=${OS}
END

)

echo "$file"
}
