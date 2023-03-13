#include <stdio.h>
#include <windows.h>
#include <GL/glut.h>
#include<string.h>
#include<math.h>
#define FALSE 0
#define TRUE 1

static MCI_OPEN_PARMS mciOpenParam1, mciOpenParam2;

// �O���[�o���ϐ�a
static float MoveX = 0; // X �������̈ړ���
static float MoveY = 0; // Y �������̈ړ���
static float MoveZ1 = -10.0; // Z �������̈ړ���1
static float MoveZ2 = -15.0; // Z �������̈ړ���2
static int numberZ1, numberZ2; // ��Q���p
static float count = 0.7; // �W�����v�p
static int t = 0; // �W�����v�p
static int jmpflag = FALSE; //�W�����v�t���O
static int rightflag = FALSE; 
static int leftflag = FALSE;
static int middleflag = FALSE;
static int finflag = FALSE; //�I��
static double dist = 100.00; // �����蔻��
static int point = 0; // score�\��

void timer(int t) // �w�莞�Ԍ�ɌĂяo�����֐��iTimer �R�[���o�b�N�֐��j
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


// �E�C���h�E�T�C�Y�ύX���ɌĂяo�����֐��iReshape �R�[���o�b�N�֐��j
void reshape(int w, int h)
{
	glViewport(0, 0, w, h);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(50.0, (double)w / h, 1.0, 100.0); // �������e
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	gluLookAt(0.0, 3.0, 5.0, 0.0, 0.0, -3.0, 0.0, 1.0, 0.0); // ���_�̐ݒ�
}
void display(void) // �`�掞�ɌĂяo�����֐��iDisplay �R�[���o�b�N�֐��j
{
	glClearColor(0.0, 0.0, 0.0, 1.0); // ��ʃN���A
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT); // ��ʃo�b�t�@�N���A
	glEnable(GL_DEPTH_TEST); // �B�ʏ�����L��

// ***********************************************************************************
// ************************* ��Q���ݒ�(15���) **************************************
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
// ******************************** �X�R�A�\�� ************************************
// ********************************************************************************

	// ������̕`��
	glPushMatrix();
	//�����Ɗg�U���̔��˗����܂Ƃ߂Đݒ�
	GLfloat mat4diff[] = { 0.8, 0.0, 0.2, 1.0 };
	glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, mat4diff);
	glTranslatef(0.6, 2.0, 0.0); //X �������� MoveX�CY �������� MoveY �����ړ�
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
// ******************************* ���̐ݒ� ****************************************
// *********************************************************************************

	//���̂̕`��
	glPushMatrix();
	GLfloat mat0ambi[] = { 0.329412, 0.223529, 0.027451, 1.0 };//�^�J
	glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT, mat0ambi); //�����̔��˗���ݒ�
	GLfloat mat0diff[] = { 0.780392, 0.568627, 0.113725, 1.0 };//�^�J
	glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, mat0diff); //�g�U���̔��˗���ݒ�
	GLfloat mat0spec[] = { 0.992157, 0.941176, 0.807843, 1.0 };//�^�J
	glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, mat0spec); //���ʌ��̔��˗���ݒ�
	GLfloat mat0shine[] = { 27.89743616 };//�^�J
	glMaterialfv(GL_FRONT_AND_BACK, GL_SHININESS, mat0shine);
	glTranslatef(MoveX, MoveY, 0.0); //X �������� MoveX�CZ �������� MoveZ �����ړ�

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

	// ���W���̕`��
	glPushMatrix(); // X ��
					//�����Ɗg�U���̔��˗����܂Ƃ߂Đݒ�
	GLfloat mat1diff[] = { 0.6, 0.2, 0.2, 1.0 };
	glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, mat1diff);
	glNormal3f(0.0, 1.0, 0.0); //�@�������̐ݒ�
	glBegin(GL_LINES);
	glVertex3f(0.0f, 0.0f, 0.0f);
	glVertex3f(2.0f, 0.0f, 0.0f);
	glEnd();
	glPopMatrix();

	glPushMatrix(); // Y ��	
					//�����Ɗg�U���̔��˗����܂Ƃ߂Đݒ�
	GLfloat mat2diff[] = { 0.2, 0.6, 0.2, 1.0 };
	glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, mat2diff);
	glNormal3f(0.0, 1.0, 0.0); //�@�������̐ݒ�
	glBegin(GL_LINES);
	glVertex3f(0.0f, 0.0f, 0.0f);
	glVertex3f(0.0f, 2.0f, 0.0f);
	glEnd();
	glPopMatrix();

	glPushMatrix(); // Z ��	
	//�����Ɗg�U���̔��˗����܂Ƃ߂Đݒ�
	GLfloat mat3diff[] = { 0.2, 0.2, 0.6, 1.0 };
	glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, mat3diff);
	glNormal3f(0.0, 1.0, 0.0); //�@�������̐ݒ�
	glBegin(GL_LINES);
	glVertex3f(0.0f, 0.0f, 0.0f);
	glVertex3f(0.0f, 0.0f, 2.0f);
	glEnd();
	glPopMatrix();

	glutSwapBuffers(); // �`����s
}
void lightInit(void) // �����̏����ݒ� (�܂Ƃ߂Ċ֐��ɂ��Ă��邾��)
{
	glEnable(GL_LIGHTING); //�����̐ݒ��L���ɂ���
	glEnable(GL_LIGHT0); //0 �Ԗڂ̌�����L���ɂ��� (8 �܂Őݒ�\)
	glEnable(GL_NORMALIZE); //�@���x�N�g���̎������K����L��
	GLfloat light0pos[] = { 0.0, 5.0, 0.0, 1.0 };
	glLightfv(GL_LIGHT0, GL_POSITION, light0pos); //���� 0 �̈ʒu��ݒ�
	GLfloat light0ambi[] = { 0.2, 0.2, 0.2, 1.0 };
	glLightfv(GL_LIGHT0, GL_AMBIENT, light0ambi); //���� 0 �̊����̐F��ݒ�
	GLfloat light0diff[] = { 0.8, 0.8, 0.8, 1.0 };
	glLightfv(GL_LIGHT0, GL_DIFFUSE, light0diff); //���� 0 �̊g�U���̐F��ݒ�
	GLfloat light0spec[] = { 0.5, 0.5, 0.5, 1.0 };
	glLightfv(GL_LIGHT0, GL_SPECULAR, light0spec); //���� 0 �̋��ʌ��̐F��ݒ�
	glShadeModel(GL_SMOOTH); //�X���[�Y�V�F�[�f�B���O�ɐݒ�
}
int main(int argc, char* argv[])
{
	glutInit(&argc, argv); // GLUT ������
	glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE | GLUT_DEPTH);
	glutInitWindowSize(640, 480); // �E�B���h�E�T�C�Y�̎w��
	glutCreateWindow("window"); // �\���E�B���h�E�쐬
	glutReshapeFunc(reshape); // Reshape �R�[���o�b�N�֐��̎w��
	glutDisplayFunc(display); // Display �R�[���o�b�N�֐��̎w��
	glutKeyboardFunc(keyboard); // �ʏ�L�[�R�[���o�b�N�֐��̎w�� (�������Ƃ�)
	glutTimerFunc(20, timer, 1);
	lightInit(); // �����̏����ݒ� (�܂Ƃ߂Ċ֐��ɂ��Ă��邾��)
	// mci �R�}���h�ɂ�� wav �̍Đ�
	// mci �f�o�C�X�̐ݒ� (���f�B�A�̎��)
	mciOpenParam1.lpstrDeviceType = (LPSTR)MCI_DEVTYPE_WAVEFORM_AUDIO;
	mciOpenParam1.lpstrElementName = "bell.wav"; // mci �f�o�C�X�̐ݒ� (�t�@�C����)
	// mci �f�o�C�X�̃I�[�v��
	mciSendCommand(NULL, MCI_OPEN, MCI_OPEN_TYPE | MCI_OPEN_TYPE_ID |
		MCI_OPEN_ELEMENT, (DWORD_PTR)&mciOpenParam1);
	// mci �f�o�C�X�̐ݒ� (���f�B�A�̎��)
	mciOpenParam2.lpstrDeviceType = (LPSTR)MCI_DEVTYPE_WAVEFORM_AUDIO;
	mciOpenParam2.lpstrElementName = "bom.wav"; // mci �f�o�C�X�̐ݒ� (�t�@�C����)
	// mci �f�o�C�X�̃I�[�v��
	mciSendCommand(NULL, MCI_OPEN, MCI_OPEN_TYPE | MCI_OPEN_TYPE_ID |
		MCI_OPEN_ELEMENT, (DWORD_PTR)&mciOpenParam2);
	PlaySound("bgm.wav", NULL, SND_FILENAME | SND_ASYNC | SND_LOOP);
	glutMainLoop(); // ���C�����[�v��
	mciSendCommand(mciOpenParam1.wDeviceID, MCI_CLOSE, 0, 0); // mci �f�o�C�X�̃N���[�Y
	mciSendCommand(mciOpenParam2.wDeviceID, MCI_CLOSE, 0, 0); // mci �f�o�C�X�̃N���[�Y

	return 0;
}
