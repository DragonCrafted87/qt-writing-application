#include "mainwindow.h"
#include "res/ui/ui_mainwindow.h"

#include <QDebug>
MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    qDebug() << "Hello World";
}

MainWindow::~MainWindow()
{
    delete ui;
}
