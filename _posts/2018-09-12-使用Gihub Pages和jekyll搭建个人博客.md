---
layout: post
title: "使用Gihub Pages和Jekyll搭建个人博客"
subtitle:   搭建博客
date:       2018-09-12 
author:     Christy
header-img: img/post-bg-2015.jpg
catalog: true
tags:
    - 博客
    - GitHub
    - Jekyll
---


之前用Digital Ocean的ghost镜像搭建过博客，后来账户余额不足，博客就停用了一阵子。经历了一个忙碌的暑假，终于又获得片刻的悠闲，所以又开始折腾博客了。

ghost博客是基于node.js的动态博客，即页面并非预先编译完成为html文件的，而是启动一个监听端口，接收前端发来的请求，做出响应。如果按照步骤搭建ghost博客，需要预装node.js，mysql以及nginx，过程也不算复杂，只是需要做一些配置工作

### Github Pages
这次搭新博客是利用了GitHub提供的方便，直接使用Github Pages。

> Github Pages 是面向用户、组织和项目开放的公共静态页面搭建托管服 务，站点可以被免费托管在 Github 上。

具体的操作就是建一个yourusername.github.io的仓库，在这个仓库下面存放你的html格式的博客文件。可以先新建一个index.html，然后访问https://yourusername.github.io，看一下是否加载了正确的文件。注意必须要使用https访问，因为GitHub默认帮你建的站点是采用加密连接的，不带https的话会无法访问。

如果你前端比较牛逼的话，那就可以直接html，css搞起了，但是如果我们只关心写作的过程，而不想费心去设计样式排版之类的，就可以考虑用Jekyll啦。

### Jekyll

> Jekyll 的核心其实是一个文本转换引擎。它的概念是：你用你最喜欢的标记语言来写文章，可以是 Markdown, 也可以是 Textile, 或者就是简单的 HTML, 然后 Jekyll 就会帮你套入一个或一系列的布局中。在整个过程中你可以设置 URL 路径，你的文本在布局中的显示样式等等。这些都可以通过纯文本编辑来实现，最终生成的静态页面就是你的成品了。

Jekyll的生态已经很丰富了，可以到[主题库](http://jekyllthemes.org/)中下载自己喜欢的模板，然后克隆到本地，接下来先在本地进行调试，再上传到github的仓库。

### 本地调试 
下载好主题后，首先要进行主题的安装，根目录下的_config.yml文件中，可以设置title,url,header-img等信息，不同模板不一样，可以参考模板仓库的Readme文件进行配置。

在安装之前，确保正确安装**Ruby**，**RubyGems**，**Jekyll**，windows安装可能会踩一些坑，不过没关系，我们可以根据后面的报错解决。

都装好了之后，在模板仓库的根目录下打开命令行，运行bundle exec jekyll serve命令，这个命令会运行你在Gemfile或者Gemfile.lock文件中指定的jekyll server版本，比jekyll serve命令稳妥一些。

如果在命令行中看到


```
  Server address: http://127.0.0.1:4000/
  Server running... press ctrl-c to stop.
```

说明启动成功，访问localhost:4000，就看到这个Jekyll模板原始的样子了。Jekyll约定在_post目录下放要写的文章。文件命名要符合: YEAR-MONTH-DAY-title.md的格式，才可以被正确转换，如果觉得自己建这样的文件名比较麻烦，可以使用脚本创建，据我所知Jekyll Bootstrap模板中带有Rakefile脚本文件。使用rake post title="titlename"命令可以自动生成，但是会存在中文乱码的情况，我还没有解决。

文件创建好后，头信息至关重要。

> 任何只要包含 YAML 头信息的文件在 Jekyll 中都能被当做一个特殊的文件来处理。头信息必须在文件的开始部分，并且需要按照 YAML 的格式写在两行三虚线之间

下面是一个头信息的例子

```
---
layout: post
title: "2018-09-12-使用Gihub Pages和jekyll搭建个人博客.md"
subtitle:   搭建博客
date:       2018-09-12
author:     xiaoheifish
catalog: true
tags:
    - 博客
    - Github
    - Jekyll
---
```


后面的具体内容就是平时怎么写markdown，现在还怎么写就好。由于Jekyll需要先编译好静态文件再访问，因此每次修改都需要先关掉当前运行的Jekyll再重启观察效果，如果大家知道有什么实时编译显示效果的插件，烦请告知。


本地预览没问题，则可以上传到远程仓库了。访问https://yourusername.github.io，就看到你的最新文章了。整理一下思路，就是我们下载了精美的模板，写好了博客内容，本地编译并加载出来看了看，觉得都ok了，但是辛辛苦苦写的东西想要大家看到啊，只有自己能看怎么行。于是我们把本地文件上传到Github仓库，由于这个仓库比较特殊，它是为建站而生的，所以Github检测到你的文件变动后，会在远端帮你编译一遍，通过之后，静态文件会被更新，大家访问你的主页，就看到热乎的博客了。而且，它的排版还很精美，忍不住对你心生赞叹（其实并没有）。


### 拓展功能

#### 评论系统
一般博客都要有评论系统的，不然怎么跟大家交流，我参照这个博主的[方法](http://qiubaiying.top/2017/12/19/%E4%B8%BA%E5%8D%9A%E5%AE%A2%E6%B7%BB%E5%8A%A0-Gitalk-%E8%AF%84%E8%AE%BA%E6%8F%92%E4%BB%B6/)，搭了博客系统。它有一步是比较挫的，就是新的文章不会自动开启评论区，需要手动点一下开启一个新的issue，博主推荐了用脚本创建issue的方法，我也尝试了，中间一直报找不到一个libcurl.dll的错误，需要去网上寻找靠谱的dll并放到ruby安装目录/bin文件夹下，貌似只有windows系统才有这个烦人的错误。

#### 域名解析

如果不喜欢默认的域名，则可以自行购买域名并添加CNAME域名解析，把你自己的域名解析到默认域名。注意：这样解析后就不支持https了，如何支持我还在摸索。Github支持顶级域名解析和子域名解析，所以你在dns服务器中可以两个都配置。不过它在实际解析的时候是依据你在项目根目录中的CNAME文件决定该使用哪个域名的。举个栗子，如果你配了example.com，那么即便你在浏览器输入了www.example.com，也会被重定向到example.com去的。

> PS：在阿里云购买了5块钱一年的域名，一天之内就失效了，目前处在域名ping不通的状态，果然便宜没好货啊！


#### 图片素材
一篇精心写好的博客最好还是配一张精致的头图，看起来也赏心悦目，我知乎上搜了搜，以下几个网站推荐人数比较多，图片质量也很好，可以从中挑选可用的素材哦。

[***lifeofpix***](https://www.lifeofpix.com/) | [***unsplash***](https://unsplash.com/public-domain-images) | [***pixabay***](https://pixabay.com/)


#### gem plugins
在_config.yml文件中，可以配置多个jekyll插件，格式如下：

```
gems:
  [jekyll-paginate,jekyll-sitemap]
```

是以数组的形式添加的，在优先级相同的情况下，也是按照添加的先后顺序执行，以我用到的两个插件为例，第一个是分页插件，第二个是根据博客标题生成地图，如果你不想让第二个插件去处理第一个插件运行后的衍生文件，那就需要调换两个插件的顺序。

#### 其他
博客还可以设置自我介绍啊，tag，社交网站链接，访问量统计什么的，[这篇博客](https://www.jianshu.com/p/e68fba58f75c)写得非常详尽了，大家可以参考以下，或者按照他的步骤从头到尾做一遍，也会搭出自己喜欢的博客的。


