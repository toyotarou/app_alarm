# app_alarm

アラームを登録・管理する Flutter アプリです。`alarm` パッケージを使用してネイティブレベルのアラームを実現し、Isar ローカルデータベースで登録データを永続化します。日付・時刻・タイトル・説明・ON/OFF フラグをアラームごとに管理でき、カスタムサウンドや通知画面にも対応しています。

---

## 主な機能

- **アラーム登録**: 日付・時刻・タイトル・説明を入力してアラームを登録
- **アラーム ON/OFF 切り替え**: 個別アラームを有効・無効に切り替え
- **全アラーム一覧**: 登録済みアラームをまとめて確認・管理
- **日次アラーム入力**: 指定日のアラームを入力するダイアログ
- **アラーム通知画面**: アラーム発火時に専用画面を表示
- **カスタムサウンド**: assets/sounds/ に収録した音声をアラーム音に使用
- **カラーピッカー**: アラームの色設定（`flutter_colorpicker`）
- **ドラッグ&ドロップ並び替え**: `drag_and_drop_lists` でアラームの順序を変更
- **CSV エクスポート**: アラームデータを CSV 形式で出力・共有

---

## 使用技術

| カテゴリ | ライブラリ |
|---|---|
| UI フレームワーク | Flutter (Material 3 off / ダークテーマ) |
| アラーム | alarm ^4.0.7 |
| 状態管理 | hooks_riverpod / flutter_riverpod / riverpod_annotation |
| ローカル DB | Isar v3.1.0 |
| 権限管理 | permission_handler |
| HTTP 通信 | http |
| 国際化 | intl |
| コード生成 | freezed / freezed_annotation / json_serializable / json_annotation |
| フォント | google_fonts (KiwiMaru) |
| グラフ | fl_chart |
| 吹き出し UI | bubble |
| 並び替え | drag_and_drop_lists |
| カラーピッカー | flutter_colorpicker |
| CSV 操作 | csv |
| ファイル操作 | file_picker / external_path / share_plus |
| 文字コード変換 | charset_converter |
| スプラッシュ | flutter_native_splash |
| ランチャーアイコン | flutter_launcher_icons |
| Linter | flutter_lints / riverpod_lint |

---

## Isar コレクション

### `AlarmCollection`
アラームの登録データを保持します。

| フィールド | 型 | 説明 |
|---|---|---|
| id | Id | 自動採番 |
| date | String | アラームの日付（インデックス付き） |
| time | String | アラームの時刻 |
| title | String | タイトル |
| description | String | 説明・メモ |
| alarmOn | int | ON/OFF フラグ（1: ON / 0: OFF） |

---

## 画面構成

```
HomeScreen（ホーム画面）
│  ※ 起動時に Alarm.init() → Isar オープン
├── alarm_notification_screen.dart   アラーム発火時の通知画面
└── components/
    ├── alarm_collection_list_alert.dart   アラームコレクション一覧
    ├── all_alarm_list_alert.dart          全アラーム一覧・管理
    ├── daily_alarm_input_alert.dart       日次アラーム入力ダイアログ
    └── parts/                             共通パーツ
```

---

## ディレクトリ構成

```
lib/
├── collections/        Isar コレクション定義（AlarmCollection）
├── controllers/        Riverpod コントローラー
├── extensions/         拡張メソッド
├── model/              データモデル
├── repository/         DB アクセス層
├── screens/            UI 画面・コンポーネント
├── utilities/          ユーティリティ関数
└── main.dart           エントリーポイント

assets/
├── sounds/             アラーム音ファイル
├── images/             画像（スプラッシュ: alarmbird.png 等）
└── fonts/              KiwiMaru フォント
```

---

## セットアップ

```bash
# 依存パッケージのインストール
flutter pub get

# Isar コード生成
dart run build_runner build --delete-conflicting-outputs

# アプリ起動
flutter run
```

### 必要な権限（Android / iOS）

| 権限 | 用途 |
|---|---|
| SCHEDULE_EXACT_ALARM（Android） | 正確な時刻でのアラーム発火 |
| 通知権限 | アラーム通知の表示 |

---

## 動作環境

- Flutter: 3.x 以上
- Dart SDK: ^3.5.0
- iOS / Android 対応（縦向き固定）
