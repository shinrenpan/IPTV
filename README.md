[![LICENSE](https://img.shields.io/badge/License-MIT-green.svg?style=flat-square)](LICENSE)
[![Donate](https://img.shields.io/badge/PayPal-Donate-yellow.svg?style=flat-square)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=LC58N7VZUST5N)

# IPTV
簡單提供網路電視 (基本上都是台灣地區電視) 在 iPhone or iPad 上觀看.  
懶得使用後台, [頻道列表][2] 放在 client 端.

![](README/1.png)

## 需求
* [ijkplayer][1] 或是下載我編譯好的 [IJKMediaFramework.framework][6].
* 實機, 因為我編譯好的 [IJKMediaFramework.framework][6] 只支援實機 (armv7 and arm64).
* Xcode 7.1.1

## 修改列表
你可以透過 iTunes 導出 / 導入電視列表, 如圖所示:
>檔名必須為 ChannelList.json  
>JSON 必須包含 title 跟 url.

![](README/2.png)


[1]: https://github.com/Bilibili/ijkplayer "ijkplayer"
[2]: IPTV/ChannelList.json "頻道列表"
[3]: https://developer.apple.com/xcode/download/ "xcode"
[4]: https://github.com/shinrenpan/IPTV/archive/master.zip "下載"
[5]: http://www.dycksir.com/2015/10/10/Launching-Your-App-on-Devices-Xcode-7-without-certificate/ "教學"
[6]: https://www.dropbox.com/s/5ltr66tyk3lxvfy/IJKMediaFramework.framework.zip?dl=0 "下載"
