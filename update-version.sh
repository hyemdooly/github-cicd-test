# 기존 version code 추출
OLD_APP_VERSION_CODE=$(grep '^appVersionCode=' appVersion.properties | cut -d'=' -f2)

# branch로부터 versionCode, versionName 변경
export APP_VERSION_NAME=`git branch --show-current | grep -Eo '\b[0-9]+\.[0-9]+\.[0-9]+\b'`

# version 추출
IFS='.'
read -r MAJOR MINOR PATCH <<< "$APP_VERSION_NAME"
NEW_APP_VERSION_CODE=$((MAJOR * 100000 + MINOR * 1000 + PATCH * 10))

# OLD_VERSION_CODE와 NEW_APP_VERSION_CODE 비교
if [ "$OLD_APP_VERSION_CODE" -eq "$NEW_APP_VERSION_CODE" ]; then
  NEW_APP_VERSION_CODE=$((NEW_APP_VERSION_CODE + 1))
fi

echo "OLD_APP_VERSION_CODE=$OLD_APP_VERSION_CODE"
echo "NEW_APP_VERSION_CODE=$NEW_APP_VERSION_CODE"
echo "NEW_APP_VERSION_NAME=$APP_VERSION_NAME"

cat << EOF > appVersion.properties
appVersionCode=$NEW_APP_VERSION_CODE
appVersionName=$APP_VERSION_NAME
EOF

# 커밋 & 푸시
git add .
git commit -m "Update Version to $APP_VERSION_NAME (${NEW_APP_VERSION_CODE: -1})"
git push origin
