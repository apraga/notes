# Autres 

- [ ] Vérifier durée concession cimetière pour thierry {#vérifier-durée-concession-cimetière-pour-thierry}

# Banques
- [X] Assurance-vie Boursorama avec vente de la maison
- [ ] Transfert à Besançon CEL, Livret B 
  Résumé: À Besançon, ouvrir un compte support épargne et
  
  -   clôturer livret B de Metz et l\'y transférer
  -   idem pour CEL ou bien simplement le transférer pour conserver
      avantages
  
  Les démarches à Metz se font à distance via la CE de Besançon Livret B:
  30k CEL 15k Placement après la vente : assurance-vie ou ouvrir un
  nouveau PEL (0.75% intérêt) Apparement, assurance-vie peut ne pas être
  bloqué sur 8 ans. Une partie est sur des fonds \"sécurisés\", l\'autre
  en bourse.

# Blog 

- [ ] emacs_tips.org
- [ ]  Life in emacs .. or in vim ? 
<https://www.reddit.com/r/emacs/comments/a5j3lc/emacs_key_binding_conventions_and_why_you_should/>
- [ ] Xmonad + conky + dzen {#xmonad-conky-dzen}
- [ ] Pass on windows {#pass-on-windows}
Install gopass : get the .zip, put the exe somewhere and add it to the
path. Then edit %APPDATA%/pasff .bat python
\"%APPDATA%`\passff`{=latex}`\passff`{=latex}.py\" %\*
And python file in the same directory. Replace pass with gopass and
\"show\" with \"ls\" (when there are no arguments)

# FreeBSD ports
- [ ] aeso
## sphinext-opengraph
- [X] Version avec LICENSE et tests sur Github {#version-avec-license-et-tests-sur-github}
- [ ] Version avec LICENSE et tests (CHEESESHOP) {#version-avec-license-et-tests-cheeseshop ordered="t"}
  - [PR upstream](https://github.com/wpilibsuite/sphinxext-opengraph/pull/44)
  - [ ] MAJ patch

## Notes
### Vérifier avec portlint, formatter avec portfmt

### PR

-   Mettre le changlog dans URL
-   Ne pas utiliser PORTREVISION si DISTVERSION est incrémenté (car sert
    aux patches freebsd)
-   Cocher \"maintainer approval\" dans le patch (et pas
    maintainer-feedback !)

### Haskell

-   Tutorial:

<https://docs.freebsd.org/en/books/porters-handbook/special/#using-cabal>

-   \"when updating from something like 1.5.0.0 to 1.5.0.1 it is usually
    sufficient to just bump the PORTVERSION. No need to refresh the
    whole USE~CABAL~ in this case.\"
-   11.4 and 12.2 are enough (no need for aarch64)

1.  Git-annex

    \"When updating such ports I do this:

    -   Run make config and turn all options OFF.
    -   Regenerate common USE~CABAL~.
    -   See if things build.
    -   Then start enabling options one by one and adjust optionalized
        dependencies until it builds.

    So yes, hs-git-annex is quite cumbersome port in this regard.\"

### Build for all jails

``` eshell
Welcome to the Emacs shell

~/projects/blog $ for i in 114Ramd64 122Ramd64 130Raarch64 130Ramd64 {
 poudriere testport -j $i -p default -o x11/kitty }

```

# Japanese

## First grade (80 kanji)

-   [x] 一
-   [x] 二
-   [x] 三
-   [x] 四
-   [x] 五
-   [x] 六
-   [x] 七
-   [x] 八
-   [x] 九
-   [x] 十
-   [x] 百
-   [x] 千
-   [x] 上
-   [x] 下
-   [ ] 左
-   [ ] 右
-   [ ] 中
-   [ ] 大
-   [x] 小
-   [ ] 月
-   [ ] 日
-   [ ] 年
-   [ ] 早
-   [ ] 木
-   [ ] 林
-   [ ] 山
-   [ ] 川
-   [ ] 土
-   [ ] 空
-   [ ] 田
-   [ ] 天
-   [ ] 生
-   [ ] 花
-   [ ] 草
-   [ ] 虫
-   [ ] 犬
-   [ ] 人
-   [ ] 名
-   [ ] 女
-   [ ] 男
-   [ ] 子
-   [ ] 目
-   [ ] 耳
-   [ ] 口
-   [ ] 手
-   [ ] 足
-   [ ] 見
-   [ ] 音
-   [ ] 力
-   [ ] 気
-   [ ] 円
-   [ ] 入
-   [ ] 出
-   [ ] 立
-   [ ] 休
-   [ ] 先
-   [ ] 夕
-   [ ] 本
-   [ ] 文
-   [ ] 字
-   [ ] 学
-   [ ] 校
-   [ ] 村
-   [ ] 町
-   [ ] 森
-   [ ] 正
-   [ ] 水
-   [ ] 火
-   [ ] 玉
-   [ ] 王
-   [ ] 石
-   [ ] 竹
-   [ ] 糸
-   [ ] 貝
-   [ ] 車
-   [ ] 金
-   [x] 雨
-   [ ] 赤
-   [ ] 青

### Second grade

-   [ ] 数
-   [ ] 多
-   [ ] 少
-   [ ] 万
-   [ ] 半
-   [ ] 形
-   [ ] 太
-   [ ] 細
-   [ ] 広
-   [ ] 長
-   [ ] 点
-   [ ] 丸
-   [ ] 交
-   [ ] 光
-   [ ] 角
-   [ ] 計
-   [ ] 直
-   [ ] 線
-   [ ] 矢
-   [ ] 弱
-   [ ] 強
-   [ ] 高
-   [ ] 同
-   [ ] 親
-   [ ] 母
-   [ ] 父
-   [ ] 姉
-   [ ] 兄
-   [ ] 弟
-   [ ] 妹
-   [ ] 自
-   [ ] 友
-   [ ] 体
-   [ ] 毛
-   [ ] 頭
-   [ ] 顔
-   [ ] 首
-   [ ] 心
-   [ ] 時
-   [ ] 曜
-   [ ] 朝
-   [ ] 昼
-   [ ] 夜
-   [ ] 分
-   [ ] 週
-   [ ] 春
-   [ ] 夏
-   [ ] 秋
-   [ ] 冬
-   [x] 今
-   [ ] 新
-   [ ] 古
-   [ ] 間
-   [ ] 方
-   [ ] 北
-   [ ] 南
-   [ ] 東
-   [ ] 西
-   [ ] 遠
-   [ ] 近
-   [x] 前
-   [ ] 後
-   [ ] 内
-   [ ] 外
-   [ ] 場
-   [x] 地
-   [ ] 国
-   [ ] 園
-   [ ] 谷
-   [ ] 野
-   [ ] 原
-   [ ] 里
-   [ ] 市
-   [ ] 京
-   [ ] 風
-   [ ] 雪
-   [ ] 雲
-   [ ] 池
-   [ ] 海
-   [ ] 岩
-   [ ] 星
-   [ ] 室
-   [ ] 戸
-   [ ] 家
-   [ ] 寺
-   [ ] 通
-   [ ] 門
-   [ ] 道
-   [ ] 話
-   [ ] 言
-   [ ] 答
-   [ ] 声
-   [ ] 聞
-   [ ] 語
-   [ ] 読
-   [ ] 書
-   [ ] 記
-   [ ] 紙
-   [ ] 画
-   [ ] 絵
-   [ ] 図
-   [ ] 工
-   [ ] 教
-   [ ] 晴
-   [ ] 思
-   [ ] 考
-   [ ] 知
-   [ ] 才
-   [ ] 理
-   [ ] 算
-   [ ] 作
-   [ ] 元
-   [ ] 食
-   [ ] 肉
-   [ ] 馬
-   [ ] 牛
-   [ ] 魚
-   [x] 鳥
-   [ ] 羽
-   [ ] 鳴
-   [ ] 麦
-   [ ] 米
-   [ ] 茶
-   [ ] 色
-   [ ] 黄
-   [ ] 黒
-   [ ] 来
-   [ ] 行
-   [ ] 帰
-   [ ] 歩
-   [ ] 走
-   [ ] 止
-   [ ] 活
-   [ ] 店
-   [ ] 買
-   [ ] 売
-   [ ] 午
-   [ ] 汽
-   [ ] 弓
-   [ ] 回
-   [ ] 会
-   [ ] 組
-   [ ] 船
-   [ ] 明
-   [ ] 社
-   [ ] 切
-   [ ] 電
-   [ ] 毎
-   [ ] 合
-   [ ] 当
-   [ ] 台
-   [ ] 楽
-   [ ] 公
-   [ ] 引
-   [ ] 科
-   [ ] 歌
-   [ ] 刀
-   [ ] 番
-   [ ] 用
-   [ ] 何

### Third grade

-   [ ] 丁
-   [ ] 世
-   [ ] 両
-   [ ] 主
-   [ ] 乗
-   [ ] 予
-   [ ] 事
-   [ ] 仕
-   [ ] 他
-   [ ] 代
-   [ ] 住
-   [ ] 使
-   [ ] 係
-   [ ] 倍
-   [ ] 全
-   [ ] 具
-   [ ] 写
-   [ ] 列
-   [ ] 助
-   [ ] 勉
-   [ ] 動
-   [ ] 勝
-   [ ] 化
-   [ ] 区
-   [ ] 医
-   [ ] 去
-   [ ] 反
-   [ ] 取
-   [ ] 受
-   [ ] 号
-   [ ] 向
-   [ ] 君
-   [ ] 味
-   [ ] 命
-   [ ] 和
-   [ ] 品
-   [ ] 員
-   [ ] 商
-   [ ] 問
-   [ ] 坂
-   [ ] 央
-   [ ] 始
-   [ ] 委
-   [ ] 守
-   [ ] 安
-   [ ] 定
-   [ ] 実
-   [ ] 客
-   [ ] 宮
-   [ ] 宿
-   [ ] 寒
-   [ ] 対
-   [ ] 局
-   [ ] 屋
-   [ ] 岸
-   [ ] 島
-   [ ] 州
-   [ ] 帳
-   [ ] 平
-   [ ] 幸
-   [ ] 度
-   [ ] 庫
-   [ ] 庭
-   [ ] 式
-   [ ] 役
-   [ ] 待
-   [ ] 急
-   [ ] 息
-   [ ] 悪
-   [ ] 悲
-   [ ] 想
-   [ ] 意
-   [ ] 感
-   [ ] 所
-   [ ] 打
-   [ ] 投
-   [ ] 拾
-   [ ] 持
-   [ ] 指
-   [ ] 放
-   [ ] 整
-   [ ] 旅
-   [ ] 族
-   [ ] 昔
-   [ ] 昭
-   [ ] 暑
-   [ ] 暗
-   [ ] 曲
-   [ ] 有
-   [ ] 服
-   [ ] 期
-   [ ] 板
-   [ ] 柱
-   [ ] 根
-   [ ] 植
-   [ ] 業
-   [ ] 様
-   [ ] 横
-   [ ] 橋
-   [ ] 次
-   [ ] 歯
-   [ ] 死
-   [ ] 氷
-   [ ] 決
-   [ ] 油
-   [ ] 波
-   [ ] 注
-   [ ] 泳
-   [ ] 洋
-   [ ] 流
-   [ ] 消
-   [ ] 深
-   [ ] 温
-   [ ] 港
-   [ ] 湖
-   [ ] 湯
-   [ ] 漢
-   [ ] 炭
-   [ ] 物
-   [ ] 球
-   [ ] 由
-   [ ] 申
-   [ ] 界
-   [ ] 畑
-   [ ] 病
-   [ ] 発
-   [ ] 登
-   [ ] 皮
-   [ ] 皿
-   [ ] 相
-   [ ] 県
-   [ ] 真
-   [ ] 着
-   [ ] 短
-   [ ] 研
-   [ ] 礼
-   [ ] 神
-   [ ] 祭
-   [ ] 福
-   [ ] 秒
-   [ ] 究
-   [ ] 章
-   [ ] 童
-   [ ] 笛
-   [ ] 第
-   [ ] 筆
-   [ ] 等
-   [ ] 箱
-   [ ] 級
-   [ ] 終
-   [ ] 緑
-   [ ] 練
-   [ ] 羊
-   [ ] 美
-   [ ] 習
-   [ ] 者
-   [ ] 育
-   [ ] 苦
-   [ ] 荷
-   [ ] 落
-   [ ] 葉
-   [ ] 薬
-   [ ] 血
-   [ ] 表
-   [ ] 詩
-   [ ] 調
-   [ ] 談
-   [ ] 豆
-   [ ] 負
-   [ ] 起
-   [ ] 路
-   [ ] 身
-   [ ] 転
-   [ ] 軽
-   [ ] 農
-   [ ] 返
-   [ ] 追
-   [ ] 送
-   [ ] 速
-   [ ] 進
-   [ ] 遊
-   [ ] 運
-   [ ] 部
-   [ ] 都
-   [ ] 配
-   [ ] 酒
-   [ ] 重
-   [x] 鉄
-   [ ] 銀
-   [ ] 開
-   [ ] 院
-   [ ] 陽
-   [ ] 階
-   [ ] 集
-   [ ] 面
-   [ ] 題
-   [ ] 飲
-   [ ] 館
-   [ ] 駅
-   [ ] 鼻

### Fourth grade

-   [ ] 不
-   [ ] 争
-   [ ] 付
-   [ ] 令
-   [x] 以
-   [ ] 仲
-   [ ] 伝
-   [ ] 位
-   [ ] 低
-   [ ] 例
-   [ ] 便
-   [ ] 信
-   [ ] 倉
-   [ ] 候
-   [ ] 借
-   [ ] 停
-   [ ] 健
-   [ ] 側
-   [ ] 働
-   [ ] 億
-   [ ] 兆
-   [ ] 児
-   [ ] 共
-   [ ] 兵
-   [ ] 典
-   [ ] 冷
-   [ ] 初
-   [ ] 別
-   [ ] 利
-   [ ] 刷
-   [ ] 副
-   [ ] 功
-   [ ] 加
-   [ ] 努
-   [ ] 労
-   [ ] 勇
-   [ ] 包
-   [ ] 卒
-   [ ] 協
-   [ ] 単
-   [ ] 博
-   [ ] 印
-   [ ] 参
-   [ ] 史
-   [ ] 司
-   [ ] 各
-   [ ] 告
-   [ ] 周
-   [ ] 唱
-   [ ] 喜
-   [ ] 器
-   [ ] 囲
-   [ ] 固
-   [ ] 型
-   [ ] 堂
-   [ ] 塩
-   [ ] 士
-   [ ] 変
-   [ ] 夫
-   [ ] 失
-   [ ] 好
-   [ ] 季
-   [ ] 孫
-   [ ] 完
-   [x] 官
-   [ ] 害
-   [ ] 察
-   [ ] 巣
-   [ ] 差
-   [ ] 希
-   [ ] 席
-   [ ] 帯
-   [ ] 底
-   [ ] 府
-   [ ] 康
-   [ ] 建
-   [ ] 径
-   [ ] 徒
-   [ ] 得
-   [ ] 必
-   [ ] 念
-   [ ] 愛
-   [ ] 成
-   [ ] 戦
-   [ ] 折
-   [ ] 挙
-   [ ] 改
-   [ ] 救
-   [ ] 敗
-   [ ] 散
-   [ ] 料
-   [ ] 旗
-   [ ] 昨
-   [ ] 景
-   [ ] 最
-   [ ] 望
-   [ ] 未
-   [ ] 末
-   [ ] 札
-   [ ] 材
-   [ ] 束
-   [ ] 松
-   [ ] 果
-   [ ] 栄
-   [ ] 案
-   [ ] 梅
-   [ ] 械
-   [ ] 極
-   [ ] 標
-   [ ] 機
-   [ ] 欠
-   [ ] 歴
-   [ ] 残
-   [ ] 殺
-   [ ] 毒
-   [ ] 氏
-   [ ] 民
-   [ ] 求
-   [ ] 治
-   [ ] 法
-   [ ] 泣
-   [ ] 浅
-   [ ] 浴
-   [ ] 清
-   [ ] 満
-   [ ] 漁
-   [ ] 灯
-   [ ] 無
-   [ ] 然
-   [ ] 焼
-   [ ] 照
-   [ ] 熱
-   [ ] 牧
-   [ ] 特
-   [ ] 産
-   [ ] 的
-   [ ] 省
-   [ ] 祝
-   [ ] 票
-   [ ] 種
-   [ ] 積
-   [ ] 競
-   [ ] 笑
-   [ ] 管
-   [ ] 節
-   [ ] 粉
-   [ ] 紀
-   [ ] 約
-   [ ] 結
-   [ ] 給
-   [ ] 続
-   [ ] 置
-   [ ] 老
-   [ ] 胃
-   [ ] 脈
-   [ ] 腸
-   [ ] 臣
-   [ ] 航
-   [ ] 良
-   [ ] 芸
-   [ ] 芽
-   [ ] 英
-   [ ] 菜
-   [ ] 街
-   [ ] 衣
-   [ ] 要
-   [ ] 覚
-   [ ] 観
-   [ ] 訓
-   [ ] 試
-   [ ] 説
-   [ ] 課
-   [ ] 議
-   [ ] 象
-   [ ] 貨
-   [ ] 貯
-   [ ] 費
-   [ ] 賞
-   [ ] 軍
-   [x] 輪
-   [ ] 辞
-   [ ] 辺
-   [ ] 連
-   [ ] 達
-   [ ] 選
-   [ ] 郡
-   [ ] 量
-   [ ] 録
-   [ ] 鏡
-   [ ] 関
-   [ ] 陸
-   [ ] 隊
-   [ ] 静
-   [ ] 順
-   [ ] 願
-   [ ] 類
-   [ ] 飛
-   [ ] 飯
-   [ ] 養
-   [ ] 験

# Maison

## Résiliation
### WAIT Eau

Les acheteurs reprendront le contrat pour éviter des frais des 2 côtés.
Rien à faire.

### WAIT Assurance

Contrat prolongé 1 mois sans en refaire un nouveau

# Projets

## org-nutrition Tracker de calories (lisp)

### Offline ?

1.  Data

    <https://fdc.nal.usda.gov/download-datasets.html> Notamment : full
    <https://fdc.nal.usda.gov/fdc-datasets/FoodData_Central_csv_2021-04-28.zip>

2.  [TODO]{.todo .TODO} Télécharger et convertir CSV en SQL

    CSV <https://github.com/mrc/el-csv> SQL
    <https://github.com/skeeto/emacsql>

### KILL REST ?

<https://tkf.github.io/emacs-request/>
<https://fdc.nal.usda.gov/api-guide.html>

### KILL Comparer REST et offline en performances

REST: search renvoie vraiment trop de résultats... Plus logique de le
faire avec le CSV mais les données sont éparpillées

### [TODO]{.todo .TODO} comprendr les données {#comprendr-les-données}

1.  Exploration

    Doc: <https://fdc.nal.usda.gov/portal-data/external/dataDictionary>
    food.csv: contient l\'identifiant (fdc~id~) et le nom (description)
    ex:
    \"fdc~id~\",\"data~type~\",\"description\",\"food~categoryid~\",\"publication~date~\"

    food~nutrient~.csv contient l\'information intéressante pour l\'ID
    (fdc~id~)
    \"id\",\"fdc~id~\",\"nutrient~id~\",\"amount\",\"data~points~\",\"derivation~id~\",\"min\",\"max\",\"median\",\"footnote\",\"min~yearacquired~\"

    Exemple : huile WESSON (fdc~id~ = 1105904) : foods.csv:
    \"1105904\",\"branded~food~\",\"WESSON Vegetable Oil 1
    GAL\",\"\",\"2020-11-13\"

    A beaucoup de nutrients : food~nutrients~.csv:
    \"1009437\",\"1105904\",\"\",\"\",\"Ingredients\",\"3\"
    \"13706913\",\"1105904\",\"203\",\"0\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706914\",\"1105904\",\"204\",\"93.33\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706915\",\"1105904\",\"205\",\"0\",\"\",\"75\",\"\",\"\",\"\",\"\",\"\"
    \"13706916\",\"1105904\",\"208\",\"867\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706917\",\"1105904\",\"269\",\"0\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706918\",\"1105904\",\"291\",\"0\",\"\",\"75\",\"\",\"\",\"\",\"\",\"\"
    \"13706919\",\"1105904\",\"301\",\"0\",\"\",\"75\",\"\",\"\",\"\",\"\",\"\"
    \"13706920\",\"1105904\",\"303\",\"0\",\"\",\"75\",\"\",\"\",\"\",\"\",\"\"
    \"13706921\",\"1105904\",\"306\",\"0\",\"\",\"75\",\"\",\"\",\"\",\"\",\"\"
    \"13706922\",\"1105904\",\"307\",\"0\",\"\",\"75\",\"\",\"\",\"\",\"\",\"\"
    \"13706923\",\"1105904\",\"318\",\"0\",\"\",\"75\",\"\",\"\",\"\",\"\",\"\"
    \"13706924\",\"1105904\",\"324\",\"0\",\"\",\"75\",\"\",\"\",\"\",\"\",\"\"
    \"13706925\",\"1105904\",\"401\",\"0\",\"\",\"75\",\"\",\"\",\"\",\"\",\"\"
    \"13706926\",\"1105904\",\"601\",\"0\",\"\",\"75\",\"\",\"\",\"\",\"\",\"\"
    \"13706927\",\"1105904\",\"605\",\"0\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706928\",\"1105904\",\"606\",\"13.33\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706929\",\"1105904\",\"645\",\"20\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706930\",\"1105904\",\"646\",\"53.33\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"

    En enlevant ceux qui sont nul (amount = 0)
    \"1009437\",\"1105904\",\"\",\"\",\"Ingredients\",\"3\"
    \"13706914\",\"1105904\",\"204\",\"93.33\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706916\",\"1105904\",\"208\",\"867\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706914\",\"1105904\",\"204\",\"93.33\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706916\",\"1105904\",\"208\",\"867\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"

    En enlevant ceux qui sont redondant, on retrouve 5 (différents des 3
    mentionnés ??) food~nutrients~.csv
    \"13706914\",\"1105904\",\"204\",\"93.33\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706916\",\"1105904\",\"208\",\"867\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706928\",\"1105904\",\"606\",\"13.33\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706929\",\"1105904\",\"645\",\"20\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"
    \"13706930\",\"1105904\",\"646\",\"53.33\",\"\",\"71\",\"\",\"\",\"\",\"\",\"\"

    Les codes ne correspondent pas à nutrient.csv ou
    nutrient~incomingname~. mais d\'après le site
    <https://fdc.nal.usda.gov/fdc-app.html#/food-details/1455596/nutrients>
    (au passage, l\'ID est encore différent) :

    -   204 = lipid
    -   208 = énergie
    -   606 = fat total saturated
    -   645 = fat total monounsaturated
    -   646 = fat total polyunsaturated

    En fait, le code est donné par nutrient~nbr~ dans nutrients.csv (!)

2.  En résumé

    Requirements : food.csv, nutrient.csv, food~nutrients~.csv

    1.  Chercher l\'ID dans food.csv (nom = description, id = fdc~id~)
    2.  Pour fdc~id~, obtenir la liste des nutriments (nutrient~id~)
        avec leurs valeurs (amonut) dans food~nutrients~.csv
    3.  Convertir l\'Id nutrient (nutrient~nbr~ = nutrient~id~) en son
        nom (nutrient~nbr~)avec nutrient.csv

## Vc-darcs
- [ ] Corriger record
- Ajouter support pour push 

