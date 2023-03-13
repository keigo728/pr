"use strict";
// Copyright(C) SEGA

// 必要事項記入欄
// セガマイページID : S24800176
// 氏名：吉田　圭吾
// コメント(工夫した点など)
// ：一番工夫した点は2人でも遊べるようにした点です。プレイヤーを動かす側とエネミー側でそれぞれ操作が可能なので交代で遊ぶことでスコア対決などできます。
// ：また、弾丸再初期化で飛んでくる弾丸の場所が変わってくるので二度楽しめるような形になっています。今回背景はとても簡単なものになってしまったのですが、魔王城のイメージで作りました。

// 以下感想です。
// ：ゲームを制作していく中で、エネミーの体力設定をして倒すことで難易度が上がっていくものとか作ってみたいなと思ったのですが、自分の実力不足でなかなか思うようなものが作れなかったのが残念でした。
// ：今回のインターン課題を通して、ゲームを作る上で自分に足りない部分を自覚することができてとても良い体験になりました。
// ：javascriptでコードを書くのは初めてで、描画するプログラミングというのもこれまであまりやってこなかった部類のプログラミングだったので、結構手探りで色々調べながら行ったのですが楽しく自分の中では楽しく課題に取り組めたと思います。





//備考 : テンキーの8↑と2↓でエネミーの操作可能(2人でも遊べる)

// 本体コード
const PROJECT_NAME = "VS SHOOTING STAR"; // このゲームの名前

// 画面情報
const WINDOW_WIDTH = 640; // 画面の横幅
const WINDOW_HEIGHT = 480; // 画面の縦幅

// 弾の情報
const NUM_BULLET = 600; // 制御する弾丸の数
const SIZE_BULLET = 12; // 弾丸の当たり判定の大きさ
const SEC_RESPAWN_BULLET = 30; // 弾丸再初期化までの時間

const deltaTime = 1.0 / 60.0; // 経過時間

// グローバル変数

let player; // プレイヤー制御
let input; // 入力制御
let grp_bullet; // 弾丸制御
const bullets = []; // 弾丸制御
let bg; // 背景制御
let sequence; // シーケンス制御z
let canvas;

// プレイヤーのクラス
class CPlayer {
    constructor() {
        // プレイヤーのパラメータ
        this.x = 0.0;
        this.y = 0.0;
        this.speed = 1.0;

        // 表示用パラメータ
        this.object = new createjs.Shape(); // プレイヤーの表示オブジェクト登録
        this.object.graphics.beginFill("#ffffff");
        this.object.graphics.drawCircle(0, 0, 12);
        this.object.x = 0;
        this.object.y = -WINDOW_HEIGHT; // 画面に映らない位置で生成する
        canvas.addChild(this.object);
    }
    update() {
        // キー入力によるプレイヤーの移動(input.[up,down,left,right])
        if (input.left) { this.x -= this.speed; }
        if (input.right) { this.x += this.speed; }
        if (input.down) { this.y += this.speed; }
        if (input.up) { this.y -= this.speed; }
        // 画面外に出さない処理
        if (this.x < 0) { this.x = 0; }
        if (this.x > WINDOW_WIDTH) { this.x = WINDOW_WIDTH; }
        if (this.y < 0) { this.y = 0; }
        if (this.y > WINDOW_HEIGHT) { this.y = WINDOW_HEIGHT; }
        // 表示オブジェクトへの位置の反映
        this.object.x = this.x;
        this.object.y = this.y;
    }
    initialize() {
        this.x = WINDOW_WIDTH * 0.3;
        this.y = WINDOW_HEIGHT * 0.5;
    }
}

// 弾のクラス
class CBullet {
    constructor() {
        // 弾のパラメータ
        this.x = 0.0;
        this.y = 0.0;
        this.vx = 0.0;
        this.vy = 0.0;
        this.speed = 0.0;
        this.timer = 0.0;
        this.delay = 0.0;

        // 表示用パラメータ
        this.object = new createjs.Shape(); // 弾の表示オブジェクト登録
        this.object.graphics.beginFill("#8B0000");
        this.object.graphics.drawCircle(0, 0, 8);
        this.object.x = 0;
        this.object.y = -WINDOW_HEIGHT; // 画面に映らない位置で生成する
        canvas.addChild(this.object);
    }
    update() {
        // 動き出すまでのディレイ処理
        if (this.timer >= this.delay) {
            this.x += this.vx * this.speed;
            this.y += this.vy * this.speed;
        }
        // 時間経過で初期位置に戻る
        if (this.timer >= SEC_RESPAWN_BULLET) {
            this.x = WINDOW_WIDTH * 0.5;
            this.y = WINDOW_HEIGHT * 0.5;
            this.timer = 0;
        }
        // deltaTimeを積算する
        this.timer += deltaTime;

        // 表示オブジェクトへの位置の反映
        this.object.x = this.x;
        this.object.y = this.y;
    }
    initialize(x, y, vx, vy, speed, delay) {
        this.x = x;
        this.y = y;
        this.vx = vx;
        this.vy = vy;
        this.speed = speed;
        this.delay = delay;
        this.timer = 0.0;
    }
}

// 弾全体を制御するクラス
class CBulletGroup {
    constructor() {
        // 弾丸の初期化
        for (let i = 0; i < NUM_BULLET; i++) {
            bullets[i] = new CBullet();
        }
    }
    initialize() { // 初期化
        // 弾の挙動を変える場合は下記と、CBulletのupdateを変更する
        for (let i = 0; i < NUM_BULLET; i++) {
            const dx = (50 + (i * 8) % 360) * Math.PI / 180.0; // 弾の角度をラジアンに変換
            const dy = (50 + (i * 5) % 360) * Math.PI / 180.0; // 弾の角度をラジアンに変換
            if (i % 2 == 0) { bullets[i].initialize(WINDOW_WIDTH * 0.7, WINDOW_HEIGHT * 0.05, Math.sin(dx), Math.sin(Math.cos(dy)), 1.0, (i - 1) * 0.05); }
            else { bullets[i].initialize(WINDOW_WIDTH * 0.7, WINDOW_HEIGHT * 0.95, -Math.sin(dx), -Math.sin(Math.cos(dy)), 1.0, i * 0.05); }
        }
    }
    update() { // 全ての弾の更新
        for (let i = 0; i < NUM_BULLET; i++) {
            bullets[i].update();
        }
        if (CBullet.timer >= SEC_RESPAWN_BULLET)
        {
            this.initialize();
        }
    }
    isHit(x, y, r) { // プレイヤーとの判定
        let ret = false;
        for (let i = 0; i < NUM_BULLET; i++) {
            const dx = x - bullets[i].x;
            const dy = y - bullets[i].y;
            const d = Math.sqrt(dx * dx + dy * dy); // 弾とプレイヤーの距離で判定
            if (d < r) {  
                ret = true;
                break;
            }
        }
        return ret;
    }
}

// 背景を制御するクラス
class CBackGround {
    constructor() {
        // 表示用パラメータ
        this.object = new createjs.Shape(); // 最背面の黒い板を表示
        this.object.graphics.beginFill("#000000");
        this.object.graphics.drawRect(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT);
        canvas.addChild(this.object);

        // 表示用パラメータ
        this.object = new createjs.Shape(); // 最背面の黒い板を表示
        this.object.graphics.beginFill("#FFE4B5");
        this.object.graphics.drawRect(0, WINDOW_HEIGHT * 0.25, WINDOW_WIDTH, WINDOW_HEIGHT / 2);
        canvas.addChild(this.object);

    }
    update() {
        // 必要に応じて、背景オブジェクトのパラメータの変更などをおこなう
    }
}

// ---------------------------------------------------------------------------------------------
// 以下のコードはチャレンジ課題です。
// ---------------------------------------------------------------------------------------------

let enemy; // チャレンジ)エネミー制御
let grp_pshot; // チャレンジ)プレイヤー弾丸制御
const pshots = []; // チャレンジ)プレイヤー弾丸制御

// 弾の情報
const NUM_PSHOT = 10; // 制御する弾丸の数
const SEC_RESPAWN_PSHOT = 3; //弾が次に使用できるまでの時間(秒)
const SEC_WAIT_PSHOT = 1; //弾を発射できる間隔(秒)
const SIZE_PSHOT = 16;

// チャレンジ課題)エネミーのクラス
class CEnemy {
    constructor() {
        // エネミーのパラメータ
        this.x = 0.0;
        this.y = 0.0;
        this.speed = 1.0;

        // 表示用パラメータ
        this.object = new createjs.Shape(); // プレイヤーの表示オブジェクト登録
        this.object.graphics.beginFill("#0000ff");
        this.object.graphics.drawCircle(0, 0, 32);
        this.object.x = 0;
        this.object.y = -WINDOW_HEIGHT; // 画面に映らない位置で生成する
        canvas.addChild(this.object);
    }
    update() {
        if (input.edown) { this.y += this.speed; }
        if (input.eup) { this.y -= this.speed; }
        // 画面外に出さない処理
        if (this.y < 0) { this.y = 0; }
        if (this.y > WINDOW_HEIGHT) { this.y = WINDOW_HEIGHT; }

        // 表示オブジェクトへの位置の反映
        this.object.x = this.x;
        this.object.y = this.y;
    }
    initialize() { //画面の上に配置
        this.x = WINDOW_WIDTH * 0.95;
        this.y = WINDOW_HEIGHT * 0.5;
    }
}

// チャレンジ課題)プレイヤーの弾のクラス(通常の弾と全く別の処理が必要なためクラスを分けている)
class CPlayerShot {
    constructor() {
        // 弾のパラメータ
        this.x = 0.0;
        this.y = 0.0;
        this.vx = 0.0;
        this.vy = 0.0;
        this.speed = 0.0;
        this.timer = 0.0;
        this.active = false;

        // 表示用パラメータ
        this.object = new createjs.Shape(); // 弾の表示オブジェクト登録
        this.object.graphics.beginFill("#ffff00");
        this.object.graphics.drawPolyStar(0, 0,16, 5, 0.6, -90);
        this.object.x = 0;
        this.object.y = -WINDOW_HEIGHT; // 画面に映らない位置で生成する
        canvas.addChild(this.object);
    }
    update() {
        // 動き出すまでのディレイ処理(ホーミングなどにつかってください)
        if (this.timer >= this.delay) {
            this.x += this.vx * this.speed;
            this.y += this.vy * this.speed;
        }
        // 時間経過で初期位置(画面外)に戻る
        if (this.timer >= SEC_RESPAWN_PSHOT) {
            this.x = WINDOW_WIDTH * 2.0;
            this.y = WINDOW_HEIGHT * 0.0;
            this.timer = 0;
            this.active = false;
        }
        // deltaTimeを積算する
        this.timer += deltaTime;

        // 表示オブジェクトへの位置の反映
        this.object.x = this.x;
        this.object.y = this.y;
    }
    isActive() { // 弾がアクティブかの確認
        return this.active;
    }
    initialize(x, y, vx, vy, speed, delay) {
        this.x = x;
        this.y = y;
        this.vx = vx;
        this.vy = vy;
        this.speed = speed;
        this.delay = delay;
        this.timer = 0.0;
        this.active = true;
    }
}

// チャレンジ用)プレイヤーの弾全体を制御するクラス
class CPlayerShotGroup {
    constructor() {
        this.timer = 0.0;
        // 弾丸の初期化
        for (let i = 0; i < NUM_PSHOT * 3; i++) {
            pshots[i] = new CPlayerShot();
        }
    }
    initialize() { // 初期化
    }
    shot(x, y) {
        for (let i = 0; i < NUM_PSHOT; i++) { //複数の弾を打つ場合撃てる弾を撃つ
            if (!pshots[i].isActive() && this.timer <= 0.0) {
                const dx = (50 + (i * 8) % 360) * Math.PI / 180.0; // 弾の角度をラジアンに変換
                const dy = (50 + (i * 5) % 360) * Math.PI / 180.0; // 弾の角度をラジアンに変換
                pshots[i].initialize(x, y, 100.0, 0, 0.1, 0); // 画面の右に向かって撃つ
                pshots[i + 3].initialize(x, y, Math.sin(90), -Math.cos(90), 3.0, 0); // 画面の右に向かって撃つ
                pshots[i + 6].initialize(x, y, Math.cos(120), -Math.sin(120), 3.0, 0); // 画面の右に向かって撃つ
                this.timer = SEC_WAIT_PSHOT;
                break;
            }
        }
    }

    update() { // 全ての弾の更新
        for (let i = 0; i < NUM_PSHOT; i++) {
            pshots[i].update();
        }
        this.timer -= deltaTime;
    }
    isHit(x, y, r) { // エネミーとの判定
        let ret = false;
        for (let i = 0; i < NUM_PSHOT; i++) {
            const dx = x - pshots[i].x;
            const dy = y - pshots[i].y;
            const d = Math.sqrt(dx * dx + dy * dy); // 弾とエネミーの距離で判定
            if (d < 2*r) {
                ret = true;
                break;
            }
        }
        return ret;
    }
}

// ---------------------------------------------------------------------------------------------
// 以下のコードはインターン課題では変更・追加の必要がありません。
// ゲームをより良くするために改変する場合は、バックアップをとって改変してください。
// ---------------------------------------------------------------------------------------------

function setup() {
    // キャンバスを作成
    canvas = new createjs.Stage("myCanvas");

    // なにかキーが押されたとき、keydownfuncという関数を呼び出す
    window.addEventListener("keydown", keydownfunc);
    window.addEventListener("keyup", keyupfunc);

    // 背景の生成
    bg = new CBackGround();

    // プレイヤー生成
    player = new CPlayer();

    // エネミー生成
    enemy = new CEnemy();

    // 入力システム生成
    input = new CInput();

    // 弾丸の生成
    grp_bullet = new CBulletGroup();

    // プレイヤーの弾丸の生成
    grp_pshot = new CPlayerShotGroup();

    // シーケンスの生成
    sequence = new CSequence();

    // tickをまわす
    createjs.Ticker.timingMode = createjs.Ticker.RAF;
    createjs.Ticker.addEventListener("tick", handleTick);
}

// 時間経過
function handleTick() {
    // システム系更新
    sequence.update();

    // 画面更新
    canvas.update();
}

// 入力のクラス
class CInput {
    constructor() {
        this.up = 0; this.down = 0; this.left = 0; this.right = 0; this.space = 0; this.shot = 0;
    }
}

// キーが押されたときに呼び出される関数
function keydownfunc(event) {
    const key_code = event.keyCode;
    if (key_code === 32) { input.space = true; }
    if (key_code === 37) { input.left = true; }
    if (key_code === 38) { input.up = true; }
    if (key_code === 39) { input.right = true; }
    if (key_code === 40) { input.down = true; }
 //   if (key_code === 65) { input.left = true; }  //A Key
 //   if (key_code === 87) { input.up = true; } //W Key
 //   if (key_code === 68) { input.right = true; } //D Key
 //   if (key_code === 83) { input.down = true; } //S Key
 //   if (key_code === 81) { input.shot = true; } //Q Key 
    if (key_code === 90) { input.shot = true; } //Z Key 
    if (key_code === 104) { input.eup = true; } //8 Key(テンキー)
    if (key_code === 98) { input.edown = true; } //2 Key(テンキー)
}

// キーが戻されたときに呼び出される関数
function keyupfunc(event) {
    const key_code = event.keyCode;
    if (key_code === 32) { input.space = false; }
    if (key_code === 37) { input.left = false; }
    if (key_code === 38) { input.up = false; }
    if (key_code === 39) { input.right = false; }
    if (key_code === 40) { input.down = false; }
 //   if (key_code === 65) { input.left = false; } //A Key
 //   if (key_code === 87) { input.up = false; } //W Key
 //   if (key_code === 68) { input.right = false; } //D Key
 //   if (key_code === 83) { input.down = false; } //S Key
 //   if (key_code === 81) { input.shot = false; } //Q Key
    if (key_code === 90) { input.shot = false; } //Z Key 
    if (key_code === 104) { input.eup = false; } //8 Key(テンキー)
    if (key_code === 98) { input.edown = false; } //2 Key(テンキー)
}

// シーケンスを制御するクラス
class CSequence {
    constructor() {
        this.score = 0;
        this.timer = 0.0;
        this.modename = "seq_title";

        this.prev_hit_pshot = false;

        // ゲームの名前
        this.tex_line0 = new createjs.Text(PROJECT_NAME, "16px serif", "White");
        this.tex_line0.textAlign = "left";
        this.tex_line0.x = 8;
        this.tex_line0.y = 8;
        canvas.addChild(this.tex_line0);

        // 操作
        this.tex_line1 = new createjs.Text("PRESS SPACE", "16px serif", "White")
        this.tex_line1.textAlign = "center";
        this.tex_line1.x = WINDOW_WIDTH * 0.5;
        this.tex_line1.y = WINDOW_HEIGHT * 0.5;
        canvas.addChild(this.tex_line1);

        // スコア
        this.tex_score = new createjs.Text("", "16px serif", "White")
        this.tex_score.textAlign = "left";
        this.tex_score.x = 8;
        this.tex_score.y = 8 + 16;
        canvas.addChild(this.tex_score);
    }
    update() {
        this.timer += deltaTime;
        switch (this.modename) {
            case "seq_title": // タイトル画面
                if (input.space) { // スペースキーが押されたら、ゲーム画面に移動
                    // プレイヤーの初期化をする
                    player.initialize();
                    enemy.initialize();
                    // 弾丸の初期化をする
                    grp_bullet.initialize();
                    grp_pshot.initialize();
                    this.score = 0;
                    this.modename = "seq_game";
                    this.timer = 0.0;
                    this.tex_line1.text = "";
                }
                break;
            case "seq_game": // ゲーム中
                this.score += 1;
                // 弾丸の更新
                grp_bullet.update();
                // 弾丸の更新
                grp_pshot.update();
                // プレイヤーの更新
                player.update();
                // エネミーの更新
                enemy.update();
                // 背景の更新
                bg.update();

                // ショットキー(z)が押されたら、プレイヤーの位置から弾を発射する
                if (input.shot) {
                    grp_pshot.shot(player.x, player.y);
                }

                // プレイヤーが弾に当たったら、結果表示に移動
                if (grp_bullet.isHit(player.x, player.y, SIZE_BULLET)) { 
                    this.modename = "seq_result";
                    this.timer = 0.0;
                    this.tex_line1.text = "PRESS SPACE";
                }
                // エネミーに弾が当たったら、
                if (grp_pshot.isHit(enemy.x, enemy.y, SIZE_PSHOT)) {
                    if (this.prev_hit_pshot == false) {
                        this.score += 100;
                    }

                } else {
                    this.prev_hit_pshot = false;
                }
                break;
            case "seq_result": // 結果表示
                if (input.space) { // スペースキーが押されたら、タイトル画面に移動
                    this.modename = "seq_title";
                    this.timer = 0.0;
                    grp_bullet.initialize();
                }
                break;
        }

        // スコアの表示用に文字列書き換え
        this.tex_score.text = "SCORE:" + this.score;
    }
}

