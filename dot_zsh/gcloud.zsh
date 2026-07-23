# Google Cloud SDK (Homebrew) — only when installed
for _gcloud_bin in /opt/homebrew/share/google-cloud-sdk/bin /usr/local/share/google-cloud-sdk/bin; do
  [[ -d $_gcloud_bin ]] && export PATH="$_gcloud_bin:$PATH"
done
unset _gcloud_bin
