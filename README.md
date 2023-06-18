# AutoSetup

## Setup your linux environment with Only One Command

### Setup All At Once
```shell
TMP_AUTOSETUP=/tmp/autosetup && rm -rf ${TMP_AUTOSETUP} && git clone -b main --depth=1 https://github.com/ZQPei/autosetup.git ${TMP_AUTOSETUP} && bash ${TMP_AUTOSETUP}/tools/setup_all.sh && rm -rf ${TMP_AUTOSETUP}
```

### Setup OMB
```shell
TMP_AUTOSETUP=/tmp/autosetup && rm -rf ${TMP_AUTOSETUP} && git clone -b main --depth=1 https://github.com/ZQPei/autosetup.git ${TMP_AUTOSETUP} && bash ${TMP_AUTOSETUP}/tools/setup_omb.sh && rm -rf ${TMP_AUTOSETUP}
```

### Setup OMZ
```shell
TMP_AUTOSETUP=/tmp/autosetup && rm -rf ${TMP_AUTOSETUP} && git clone -b main --depth=1 https://github.com/ZQPei/autosetup.git ${TMP_AUTOSETUP} && bash ${TMP_AUTOSETUP}/tools/setup_omz.sh && rm -rf ${TMP_AUTOSETUP}
```

### Setup User Dot Files
```shell
TMP_AUTOSETUP=/tmp/autosetup && rm -rf ${TMP_AUTOSETUP} && git clone -b main --depth=1 https://github.com/ZQPei/autosetup.git ${TMP_AUTOSETUP} && bash ${TMP_AUTOSETUP}/tools/setup_userfile.sh && rm -rf ${TMP_AUTOSETUP}
```
