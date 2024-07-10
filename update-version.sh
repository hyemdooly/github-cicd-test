# update version
# versionCode, versionName 변경
export APP_VERSION_NAME=`git branch --show-current | grep -Eo '\b[0-9]+\.[0-9]+\.[0-9]+\b'`

# version 추출
IFS='.'
read -r MAJOR MINOR PATCH <<< "$APP_VERSION_NAME"
APP_VERSION_CODE=$((MAJOR * 10000 + MINOR * 100 + PATCH))
IFS=' '

echo "APP_VERSION_CODE=$APP_VERSION_CODE"
echo "APP_VERSION_NAME=$APP_VERSION_NAME"

cat << EOF > appVersion.properties
appVersionCode=$APP_VERSION_CODE
appVersionName=$APP_VERSION_NAME
EOF

# 커밋 & 푸시
git add .
git commit -m "Update Version to $APP_VERSION_NAME"
git push origin
