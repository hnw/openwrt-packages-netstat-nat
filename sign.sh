set -eu

SECRET_KEY=$1

cd /work/pkgs-for-bintray
for file in Packages Packages.gz; do
    if [[ -e "$file" ]] ; then
        echo $SECRET_KEY | base64 -d | /home/openwrt/sdk/staging_dir/host/bin/usign -S -m "$file" -s -
        echo /home/openwrt/sdk/staging_dir/host/bin/usign -S -m "$file" -s -
    fi
done
