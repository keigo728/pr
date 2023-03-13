#include <stdio.h>
#include <windows.h>
#include <GL/glut.h>
#include<string.h>
#include<math.h>
#define FALSE 0
#define TRUE 1

static MCI_OPEN_PARMS mciOpenParam1, mciOpenParam2;

// グローバル変数a
static float MoveX = 0; // X 軸方向の移動量
static float MoveY = 0; // Y 軸方向の移動量
static float MoveZ1 = -10.0; // Z 軸方向の移動量1
static float MoveZ2 = -15.0; // Z 軸方向の移動量2
static int numberZ1, numberZ2; // 障害物用
static float count = 0.7; // ジャンプ用
static int t = 0; // ジャンプ用
static int jmpflag = FALSE; //ジャンプフラグ
static int rightflag = FALSE; 
static int leftflag = FALSE;
static int middleflag = FALSE;
static int finflag = FALSE; //終了
static double dist = 100.00; // 当たり判定
static int point = 0; // score表示

void timer(int t) // 指定時間後に呼び出される関数（Timer コールバック関数）
{
	if (finflag == FALSE)
	{
		glutPostRedisplay();
	}
	if (finflag == TRUE)
	{
		PlaySound(NULL, NULL, 0);
	}
	glutTimerFunc(20, timer, 1);
}

void keyboard(unsigned char key, int x, int y)
{
	switch (key) {
	case ' ':
		jmpflag = TRUE;
		break;
	case 'q':
		finflag = TRUE;
		break;
	case 'a':
		leftflag = TRUE;
		rightflag = FALSE;
		middleflag = FALSE;
		break;
	case 'd':
		leftflag = FALSE;
		rightflag = TRUE;
		middleflag = FALSE;
		break;
	case 's':
		leftflag = FALSE;
		rightflag = FALSE;
		middleflag = TRUE;
		break;
	case 'r':
		finflag = FALSE;
		break;
	}
}


// ウインドウサイズ変更時に呼び出される関数（Reshape コールバック関数）
void reshape(int w, int h)
{
	glViewport(0, 0, w, h);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(50.0, (double)w / h, 1.0, 100.0); // 透視投影
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	gluLookAt(0.0, 3.0, 5.0, 0.0, 0.0, -3.0, 0.0, 1.0, 0.0); // 視点の設定
}
void display(void) // 描画時に呼び出される関数（Display コールバック関数）
{
	glClearColor(0.0, 0.0, 0.0, 1.0); // 画面クリア
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT); // 画面バッファクリア
	glEnable(GL_DEPTH_TEST); // 隠面消去を有効

// ***********************************************************************************
// ************************* 障害物設定(15種類) **************************************
// ***********************************************************************************

	if (MoveZ1 < -9.9)
		numberZ1 = rand() % 15;

	switch (numberZ1)
	{
		//1234
	case 0:
		glPushMatrix();
		glTranslatef(2.4, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ1 += 0.2;
		if (MoveZ1 > -1.35 && MoveZ1 < 0.5)
		{
			dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY) * (MoveY) + (MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4)+(MoveY - 2.4) * (MoveY - 2.4)+(MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
		}
		break;
		//1235
	case 1:
		glPushMatrix();
		glTranslatef(2.4, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ1 += 0.2;
		if (MoveZ1 > -1.35 && MoveZ1 < 0.5)
		{
			dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX) * (MoveX) + (MoveY - 2.4) * (MoveY - 2.4)+(MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX) * (MoveX) + (MoveY - 2.4) * (MoveY - 2.4)+(MoveZ1) * (MoveZ1));
		}
		break;
		//1236
	case 2:
		glPushMatrix();
		glTranslatef(2.4, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(2.4, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ1 += 0.2;
		if (MoveZ1 > -1.35 && MoveZ1 < 0.5)
		{
			dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX - 2.4) * (MoveX - 2.4)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX - 2.4) * (MoveX - 2.4)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
		}
		break;
		//1245
	case 3:
		glPushMatrix();
		glTranslatef(2.4, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ1 += 0.2;
		if (MoveZ1 > -1.35 && MoveZ1 < 0.5)
		{
			dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX) * (MoveX) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX) * (MoveX) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
		}
		break;
		//1246
	case 4:
		glPushMatrix();
		glTranslatef(2.4, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(2.4, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ1 += 0.2;
		if (MoveZ1 > -1.35 && MoveZ1 < 0.5)
		{
			dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
		}
		break;
		//1256
	case 5:
		glPushMatrix();
		glTranslatef(2.4, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ1 += 0.2;
		if (MoveZ1 > -1.35 && MoveZ1 < 0.5)
		{
			dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
		}
		break;
		//1345
	case 6:
		glPushMatrix();
		glTranslatef(2.4, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ1 += 0.2;
		if (MoveZ1 > -1.35 && MoveZ1 < 0.5)
		{
			dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
		
		}
		break;
		//1346
	case 7:
		glPushMatrix();
		glTranslatef(2.4, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(2.4, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ1 += 0.2;
		if (MoveZ1 > -1.35 && MoveZ1 < 0.5)
		{
			dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
		}
		break;
		//1356
	case 8:
		glPushMatrix();
		glTranslatef(2.4, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(2.4, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ1 += 0.2;
		if (MoveZ1 > -1.35 && MoveZ1 < 0.5)
		{
			dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
		}
		break;
		//1456
	case 9:
		glPushMatrix();
		glTranslatef(2.4, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(2.4, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ1 += 0.2;
		if (MoveZ1 > -1.35 && MoveZ1 < 0.5)
		{
			dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
		}
		break;
		//2345
	case 10:
		glPushMatrix();
		glTranslatef(0.0, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ1 += 0.2;
		if (MoveZ1 > -1.35 && MoveZ1 < 0.5)
		{
			dist = sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
		}
		break;
		//2346
	case 11:
		glPushMatrix();
		glTranslatef(0.0, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(2.4, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ1 += 0.2;
		if (MoveZ1 > -1.35 && MoveZ1 < 0.5)
		{
			dist = sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
		}
		break;
		//2356
	case 12:
		glPushMatrix();
		glTranslatef(0.0, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(2.4, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ1 += 0.2;
		if (MoveZ1 > -1.35 && MoveZ1 < 0.5)
		{
			dist = sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
		}
		break;
		//2456
	case 13:
		glPushMatrix();
		glTranslatef(0.0, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(2.4, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ1 += 0.2;
		if (MoveZ1 > -1.35 && MoveZ1 < 0.5)
		{
			dist = sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
		}
		break;
		//3456
	case 14:
		glPushMatrix();
		glTranslatef(-2.4, 0.0, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(2.4, 2.4, MoveZ1);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ1 += 0.2;
		if (MoveZ1 > -1.35 && MoveZ1 < 0.5)
		{
			dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
			if (dist > sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1)))
				dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ1) * (MoveZ1));
		}
		break;
	}

	if (MoveZ1 > 0.5)
	{
		MoveZ1 = -10.0;
		point++;
	}

	if (MoveZ1 > -4.9 && MoveZ1 < -5.1)
		numberZ2 = rand() % 15;

	switch (numberZ2)
	{
		//1234
	case 0:
		glPushMatrix();
		glTranslatef(2.4, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ2 += 0.2;
		if (MoveZ2 > -1.35 && MoveZ2 < 0.5)
		{
			dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
		}
		break;
		//1235
	case 1:
		glPushMatrix();
		glTranslatef(2.4, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ2 += 0.2;
		if (MoveZ2 > -1.35 && MoveZ2 < 0.5)
		{
			dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
		}
		break;
		//1236
	case 2:
		glPushMatrix();
		glTranslatef(2.4, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(2.4, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ2 += 0.2;
		if (MoveZ2 > -1.35 && MoveZ2 < 0.5)
		{
			dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
		}
		break;
		//1245
	case 3:
		glPushMatrix();
		glTranslatef(2.4, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ2 += 0.2;
		if (MoveZ2 > -1.35 && MoveZ2 < 0.5)
		{
			dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
		}
		break;
		//1246
	case 4:
		glPushMatrix();
		glTranslatef(2.4, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(2.4, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ2 += 0.2;
		if (MoveZ2 > -1.35 && MoveZ2 < 0.5)
		{
			dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
		}
		break;
		//1256
	case 5:
		glPushMatrix();
		glTranslatef(2.4, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ2 += 0.2;
		if (MoveZ2 > -1.35 && MoveZ2 < 0.5)
		{
			dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
		}
		break;
		//1345
	case 6:
		glPushMatrix();
		glTranslatef(2.4, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ2 += 0.2;
		if (MoveZ2 > -1.35 && MoveZ2 < 0.5)
		{
			dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
		}
		break;
		//1346
	case 7:
		glPushMatrix();
		glTranslatef(2.4, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(2.4, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ2 += 0.2;
		if (MoveZ2 > -1.35 && MoveZ2 < 0.5)
		{
			dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
		}
		break;
		//1356
	case 8:
		glPushMatrix();
		glTranslatef(2.4, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(2.4, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ2 += 0.2;
		if (MoveZ2 > -1.35 && MoveZ2 < 0.5)
		{
			dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
		}
		break;
		//1456
	case 9:
		glPushMatrix();
		glTranslatef(2.4, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(2.4, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ2 += 0.2;
		if (MoveZ2 > -1.35 && MoveZ2 < 0.5)
		{
			dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
		}
		break;
		//2345
	case 10:
		glPushMatrix();
		glTranslatef(0.0, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ2 += 0.2;
		if (MoveZ2 > -1.35 && MoveZ2 < 0.5)
		{
			dist = sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
		}
		break;
		//2346
	case 11:
		glPushMatrix();
		glTranslatef(0.0, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(2.4, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ2 += 0.2;
		if (MoveZ2 > -1.35 && MoveZ2 < 0.5)
		{
			dist = sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
		}
		break;
		//2356
	case 12:
		glPushMatrix();
		glTranslatef(0.0, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(2.4, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ2 += 0.2;
		if (MoveZ2 > -1.35 && MoveZ2 < 0.5)
		{
			dist = sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
		}
		break;
		//2456
	case 13:
		glPushMatrix();
		glTranslatef(0.0, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(2.4, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ2 += 0.2;
		if (MoveZ2 > -1.35 && MoveZ2 < 0.5)
		{
			dist = sqrt((MoveX) * (MoveX)+(MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
			if (dist > sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
				dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
		}
		break;
		//3456
	case 14:
		glPushMatrix();
		glTranslatef(-2.4, 0.0, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(-2.4, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(0.0, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		glPushMatrix();
		glTranslatef(2.4, 2.4, MoveZ2);
		glutSolidCube(1.3);
		glPopMatrix();
		MoveZ2 += 0.2;
		if (MoveZ2 > -1.35 && MoveZ2 < 0.5)
		{
				dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY) * (MoveY)+(MoveZ2) * (MoveZ2));
				if (dist > sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
					dist = sqrt((MoveX + 2.4) * (MoveX + 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
				if (dist > sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
					dist = sqrt((MoveX) * (MoveX)+(MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
				if (dist > sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2)))
					dist = sqrt((MoveX - 2.4) * (MoveX - 2.4) + (MoveY - 2.4) * (MoveY - 2.4) + (MoveZ2) * (MoveZ2));
		}
		break;
	}

	if (MoveZ2 > 0.5)
	{
		MoveZ2 = -10.0;
		point++;
	}

	if (dist < 1.0)
	{
		mciSendCommand(mciOpenParam2.wDeviceID, MCI_SEEK, MCI_SEEK_TO_START, 0);
		mciSendCommand(mciOpenParam2.wDeviceID, MCI_PLAY, 0, 0);
		finflag = TRUE;
		
	}

// ********************************************************************************
// ******************************** スコア表示 ************************************
// ********************************************************************************

	// 文字列の描画
	glPushMatrix();
	//環境光と拡散光の反射率をまとめて設定
	GLfloat mat4diff[] = { 0.8, 0.0, 0.2, 1.0 };
	glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, mat4diff);
	glTranslatef(0.6, 2.0, 0.0); //X 軸方向に MoveX，Y 軸方向に MoveY だけ移動
	glRasterPos3f(1.0f, 1.0f, 1.0f);
	char buf[32];
	sprintf_s(buf, 32, "score %d", point);
	char* str = &buf[0];

	while (*str) {
		glutBitmapCharacter(GLUT_BITMAP_HELVETICA_18, *str);
		++str;
	}
	glPopMatrix();

// *********************************************************************************
// ******************************* 球の設定 ****************************************
// *********************************************************************************

	//物体の描画
	glPushMatrix();
	GLfloat mat0ambi[] = { 0.329412, 0.223529, 0.027451, 1.0 };//真鍮
	glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT, mat0ambi); //環境光の反射率を設定
	GLfloat mat0diff[] = { 0.780392, 0.568627, 0.113725, 1.0 };//真鍮
	glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, mat0diff); //拡散光の反射率を設定
	GLfloat mat0spec[] = { 0.992157, 0.941176, 0.807843, 1.0 };//真鍮
	glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, mat0spec); //鏡面光の反射率を設定
	GLfloat mat0shine[] = { 27.89743616 };//真鍮
	glMaterialfv(GL_FRONT_AND_BACK, GL_SHININESS, mat0shine);
	glTranslatef(MoveX, MoveY, 0.0); //X 軸方向に MoveX，Z 軸方向に MoveZ だけ移動

	if (MoveX > 2.6)
		MoveX = 2.4;
	if (MoveX < -2.6)
		MoveX = -2.4;

	if (jmpflag == TRUE)
	{
		MoveY += count;
		count =  count - 0.1;
		t++;
		if (t  == 15) {
			jmpflag = FALSE;
			count = 0.7;
			t = 0;
		}

	}
	if (middleflag == TRUE)
	{
		if (MoveX < -0.1)
			MoveX += 0.2;
		else if (MoveX > 0.1)
			MoveX -= 0.2;
		else
			MoveX = 0;
	}

	if (leftflag == TRUE)
	{
		MoveX -= 0.4;
	}

	if (rightflag == TRUE)
	{
		MoveX += 0.4;
	}

	glutSolidSphere(0.7, 20, 10);

	glPopMatrix();

	// 座標軸の描画
	glPushMatrix(); // X 軸
					//環境光と拡散光の反射率をまとめて設定
	GLfloat mat1diff[] = { 0.6, 0.2, 0.2, 1.0 };
	glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, mat1diff);
	glNormal3f(0.0, 1.0, 0.0); //法線方向の設定
	glBegin(GL_LINES);
	glVertex3f(0.0f, 0.0f, 0.0f);
	glVertex3f(2.0f, 0.0f, 0.0f);
	glEnd();
	glPopMatrix();

	glPushMatrix(); // Y 軸	
					//環境光と拡散光の反射率をまとめて設定
	GLfloat mat2diff[] = { 0.2, 0.6, 0.2, 1.0 };
	glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, mat2diff);
	glNormal3f(0.0, 1.0, 0.0); //法線方向の設定
	glBegin(GL_LINES);
	glVertex3f(0.0f, 0.0f, 0.0f);
	glVertex3f(0.0f, 2.0f, 0.0f);
	glEnd();
	glPopMatrix();

	glPushMatrix(); // Z 軸	
	//環境光と拡散光の反射率をまとめて設定
	GLfloat mat3diff[] = { 0.2, 0.2, 0.6, 1.0 };
	glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, mat3diff);
	glNormal3f(0.0, 1.0, 0.0); //法線方向の設定
	glBegin(GL_LINES);
	glVertex3f(0.0f, 0.0f, 0.0f);
	glVertex3f(0.0f, 0.0f, 2.0f);
	glEnd();
	glPopMatrix();

	glutSwapBuffers(); // 描画実行
}
void lightInit(void) // 光源の初期設定 (まとめて関数にしているだけ)
{
	glEnable(GL_LIGHTING); //光源の設定を有効にする
	glEnable(GL_LIGHT0); //0 番目の光源を有効にする (8 個まで設定可能)
	glEnable(GL_NORMALIZE); //法線ベクトルの自動正規化を有効
	GLfloat light0pos[] = { 0.0, 5.0, 0.0, 1.0 };
	glLightfv(GL_LIGHT0, GL_POSITION, light0pos); //光源 0 の位置を設定
	GLfloat light0ambi[] = { 0.2, 0.2, 0.2, 1.0 };
	glLightfv(GL_LIGHT0, GL_AMBIENT, light0ambi); //光源 0 の環境光の色を設定
	GLfloat light0diff[] = { 0.8, 0.8, 0.8, 1.0 };
	glLightfv(GL_LIGHT0, GL_DIFFUSE, light0diff); //光源 0 の拡散光の色を設定
	GLfloat light0spec[] = { 0.5, 0.5, 0.5, 1.0 };
	glLightfv(GL_LIGHT0, GL_SPECULAR, light0spec); //光源 0 の鏡面光の色を設定
	glShadeModel(GL_SMOOTH); //スムーズシェーディングに設定
}
int main(int argc, char* argv[])
{
	glutInit(&argc, argv); // GLUT 初期化
	glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE | GLUT_DEPTH);
	glutInitWindowSize(640, 480); // ウィンドウサイズの指定
	glutCreateWindow("window"); // 表示ウィンドウ作成
	glutReshapeFunc(reshape); // Reshape コールバック関数の指定
	glutDisplayFunc(display); // Display コールバック関数の指定
	glutKeyboardFunc(keyboard); // 通常キーコールバック関数の指定 (押したとき)
	glutTimerFunc(20, timer, 1);
	lightInit(); // 光源の初期設定 (まとめて関数にしているだけ)
	// mci コマンドによる wav の再生
	// mci デバイスの設定 (メディアの種類)
	mciOpenParam1.lpstrDeviceType = (LPSTR)MCI_DEVTYPE_WAVEFORM_AUDIO;
	mciOpenParam1.lpstrElementName = "bell.wav"; // mci デバイスの設定 (ファイル名)
	// mci デバイスのオープン
	mciSendCommand(NULL, MCI_OPEN, MCI_OPEN_TYPE | MCI_OPEN_TYPE_ID |
		MCI_OPEN_ELEMENT, (DWORD_PTR)&mciOpenParam1);
	// mci デバイスの設定 (メディアの種類)
	mciOpenParam2.lpstrDeviceType = (LPSTR)MCI_DEVTYPE_WAVEFORM_AUDIO;
	mciOpenParam2.lpstrElementName = "bom.wav"; // mci デバイスの設定 (ファイル名)
	// mci デバイスのオープン
	mciSendCommand(NULL, MCI_OPEN, MCI_OPEN_TYPE | MCI_OPEN_TYPE_ID |
		MCI_OPEN_ELEMENT, (DWORD_PTR)&mciOpenParam2);
	PlaySound("bgm.wav", NULL, SND_FILENAME | SND_ASYNC | SND_LOOP);
	glutMainLoop(); // メインループへ
	mciSendCommand(mciOpenParam1.wDeviceID, MCI_CLOSE, 0, 0); // mci デバイスのクローズ
	mciSendCommand(mciOpenParam2.wDeviceID, MCI_CLOSE, 0, 0); // mci デバイスのクローズ

	return 0;
}
