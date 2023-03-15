# AutoSetup

## Setup your linux environment with Only One Command

```shell
TMP_AUTOSETUP=/tmp/autosetup && rm -rf ${TMP_AUTOSETUP} && git clone -b main --depth=1 https://github.com/ZQPei/autosetup.git ${TMP_AUTOSETUP} && bash ${TMP_AUTOSETUP}/tools/setup.sh && rm -rf ${TMP_AUTOSETUP}
```
