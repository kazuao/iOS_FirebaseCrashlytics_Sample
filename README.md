# Firebase Crashlytics導入方法
## 手順
1. Firebase上でのプロジェクトの作成
2. Firebase上でのアプリの登録
3. アプリへcocoapodsでのFirebase, Crashlyticsの導入
4. アプリの設定
5. 拡張ログの仕込み
6. スキーマごとのFirebase Crashlytics計測を分ける

## 詳細
1. Firebase上でのプロジェクトの作成
　プロジェクトを作成する。
　アプリの1プロジェクトにつき、Firebase1プロジェクト（設計による）
　`https://firebase.google.com/docs/ios/setup?hl=ja`

2. Firebase上でのアプリの登録

3. アプリへcocoapodsでのFirebase, Crashlyticsの導入
　↓基本手順
　`https://firebase.google.com/docs/crashlytics/get-started?hl=ja`

	`$(SRCROOT)/$(BUILT_PRODUCTS_DIR)/$(INFOPLIST_PATH)`の記述は、Xcode10のみとなっているが、
	Xcode10以上ですべて必要なため、必ず記載する。

4. アプリの設定
　基本的には、上記設定でOK
　クラッシュテストを行う際の注意事項としては、
　[プロジェクトのデバッグ設定を調整する]という項目と、
　Xcode上でビルドしたプロジェクトを、端末もしくはシミュレータ上で起動し直し、クラッシュさせること。
　（Xcodeのrunで行った場合、クラッシュログが飛ばない）
	`https://firebase.google.com/docs/crashlytics/force-a-crash?hl=ja`
	`https://qiita.com/nnishimura/items/af6bb67c0b10cdb5ecd1`

5. 拡張ログの仕込み
Crashlyticsの基幹クラスを作成し、画面ごとに拡張ログを取得する。
https://firebase.google.com/docs/crashlytics/customize-crash-reports?hl=ja

6. スキーマごとのFirebase Crashlytics計測を分ける
- ビルドターゲットを分けずに、ビルドスキーマで分ける場合
（ビルドスキーマを分ける方法は省略）

`TARGETS > Build Phases`から、3つのrun scriptを作成する。
（名前は任意のもの）
・GoogleService Run Script
・dSYM Upload Run Script
・Fabric Run Script

- GoogleService Run Script
```
if [ "${CONFIGURATION}" == "Release" ]; then
    cp "${PROJECT_DIR}/${PROJECT_NAME}/Configuration/GoogleService-Info-release.plist"  "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"
    echo "Production GoogleService-Info copied."
else
    cp "${PROJECT_DIR}/${PROJECT_NAME}/Configuration/GoogleService-Info-debug.plist"  "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"
    echo "Debug GoogleService-Info copied."
fi
```
この内、[Congiguration]と、[GoogleService-Info.plist]の名前、パスは環境に合わせて作成すること。
（パスの`${PROJECT_NAME}`は、パスが通らない可能性があるので、注意する。

- dSYM Upload Run Script
```
if [ "${CONFIGURATION}" = "Release" ]; then
GOOGLE_APP_ID=1:1073774792999:ios:afaf4ed51e2b4005669902
echo "Configure Release"

elif [ "${CONFIGURATION}" = "Debug" ]; then
GOOGLE_APP_ID=1:1073774792999:ios:9338570249c0b285669902
echo "Configure Debug"

fi

find $BUILT_PRODUCTS_DIR -name "*.dSYM" | xargs -I \{\} $PODS_ROOT/Fabric/upload-symbols -gsp ${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist -p ios \{\}
```
（[GoogleService Run Script]と同様、`GOOGLE_APP_IDは`、ダウンロードした`GoogleService-Info.plist`を参照すること）

- Fabric Run Script
[3. アプリへcocoapodsでのFirebase, Crashlyticsの導入]で設定したもの。
必ず、上記2つのRun Scriptより、あと（下）に配置すること。

https://stackoverflow.com/questions/35159244/xcode-there-are-no-dsyms-available-for-download/35159653

 - Firebase CrashlyticsへのdSYMアップロード
Xcodeの`Window>Organizer`を開く、アップロードしたいビルドを右クリックし、`Show in Finder`を選択する。
選択されている`.xcarchive`ファイルを右クリックし、「パッケージの内容を表示」を選択する。
`dSYMs`のディレクトリを右クリックし、「圧縮」を選択する。
作成した`dSYMs.zip`ファイルをFirebase CrashlyticsのdSYMアップロード画面でアップロードを行う。



