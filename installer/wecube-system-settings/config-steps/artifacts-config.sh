echo -e "\nConfiguring artifacts..."

DOWNLOAD_DIR=$(realpath "./download")
mkdir -p "$DOWNLOAD_DIR"

for ARTIFACT_URL in "${ARTIFACTS_PKGS[@]}"; do
	ARTIFACT_FILE="$DOWNLOAD_DIR/${ARTIFACT_URL##*'/'}"
	echo "Fetching artifact from $ARTIFACT_URL"
	../curl-with-retry.sh -fL $ARTIFACT_URL -o $ARTIFACT_FILE
done

if [ -n "$ARTIFACTS_COS_REGION" ] && [ -n "$ARTIFACTS_COS_BUCKET" ] && [ -n "$ARTIFACTS_COS_OBJECTS" ]; then
	echo -e "\nFetching artifacts from TencentCloud COS..."
	PYTHON_SCRIPT_FILE=$(realpath "./download-objects-in-bucket.py")

	PIP_MIRROR_PARAM=""
	if [ "$USE_MIRROR_IN_MAINLAND_CHINA" == "true" ]; then
		echo 'Using mirror for pip index in Mainland China https://pypi.tuna.tsinghua.edu.cn/simple'
		PIP_MIRROR_PARAM="-i https://pypi.tuna.tsinghua.edu.cn/simple"
	fi
	read -d '' SHELL_CMD <<-EOF || true
		pip install $PIP_MIRROR_PARAM -U crcmod cos-python-sdk-v5 && \
		python $PYTHON_SCRIPT_FILE \
			$ARTIFACTS_COS_SECRETID $ARTIFACTS_COS_SECRETKEY \
			$ARTIFACTS_COS_REGION $ARTIFACTS_COS_BUCKET \"${ARTIFACTS_COS_OBJECTS[*]}\" \
			$DOWNLOAD_DIR
	EOF
	docker run --rm -t \
		-v "$PYTHON_SCRIPT_FILE:$PYTHON_SCRIPT_FILE" \
		-v "$DOWNLOAD_DIR:$DOWNLOAD_DIR" \
		python:3 /bin/sh -c "$SHELL_CMD"
fi

echo -e "\nUploading artifacts to plugin storage..."
SHELL_SCRIPT_FILE=$(realpath "./upload-all-files-in-dir-to-minio.sh")
docker run --rm -t \
	-v "$DOWNLOAD_DIR:$DOWNLOAD_DIR" \
	-v "$SHELL_SCRIPT_FILE:$SHELL_SCRIPT_FILE" \
	--env "S3_URL=$S3_URL" --env "S3_ACCESS_KEY=$S3_ACCESS_KEY"  --env "S3_SECRET_KEY=$S3_SECRET_KEY" \
	--env "DOWNLOAD_DIR=$DOWNLOAD_DIR" --env "ARTIFACTS_S3_BUCKET_NAME=$ARTIFACTS_S3_BUCKET_NAME" \
	--env "SHOULD_CREATE_ARTIFACTS_BUCKET=$SHOULD_CREATE_ARTIFACTS_BUCKET" \
	--entrypoint=/bin/sh \
	minio/mc:RELEASE.2020-11-25T23-04-07Z "$SHELL_SCRIPT_FILE"
