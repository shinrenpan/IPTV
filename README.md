[![LICENSE](https://img.shields.io/badge/License-MIT-green.svg?style=flat-square)](LICENSE)
[![Donate](https://img.shields.io/badge/Donate-PayPal-yellow.svg?style=flat-square)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=LC58N7VZUST5N)


An iOS universal video player app, I use it to watch IPTV.

[中文說明][0]

![](README/1.png)


## Required ##
- [SRPPlayerViewController][2]
- [ijkplayer][3]


## Build ##
Follow [SRPPlayerViewController][2] step to build framework.

You need **SRPPlayerViewController.framework, IJKMediaFramework.framework, libcrypto.a, libssl.a**, drag them into SRPPlayerViewController folder.

![](README/2.png)

Don't forget add `libz.tbd`.

![](README/3.png)


## TV Channel ##
This app doesn't provide any IPTV content, you should import it manually.

Click add button to add new IPTV content or use iTunes File Sharing to edit it.

The IPTV content saved in [ChannelList.plist][1].






[0]: README_TW.md
[1]: IPTV/ChannelList.plist "ChannelList.plist"
[2]: https://github.com/shinrenpan/SRPPlayerViewController "SRPPlayerViewController"
[3]: https://github.com/Bilibili/ijkplayer "ijkplayer"
