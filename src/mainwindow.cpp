#include "mainwindow.h"

#include <QAction>
#include <QCloseEvent>
#include <QCoreApplication>
#include <QDebug>
#include <QMessageBox>
#include <Qt>
#include <QtGlobal>

#include "res/ui/ui_mainwindow.h"

MainWindow::MainWindow(QWidget * parent) : QMainWindow(parent), ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    qDebug() << "Starting up" << APPLICATION_NAME << APPLICATION_VERSION;

    connect(ui->actionNew, &QAction::triggered, this, &MainWindow::newDocument);
    connect(ui->actionOpen, &QAction::triggered, this, &MainWindow::openDocument);
    connect(ui->actionSave, &QAction::triggered, this, &MainWindow::saveDocument);
    connect(ui->actionExit,
            &QAction::triggered,
            QCoreApplication::instance(),
            &QCoreApplication::quit,
            Qt::QueuedConnection);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::newDocument()
{
    qDebug() << "MainWindow::newDocument";
}
void MainWindow::openDocument()
{
    qDebug() << "MainWindow::openDocument";
}
void MainWindow::saveDocument()
{
    qDebug() << "MainWindow::saveDocument";
}

void MainWindow::closeEvent(QCloseEvent * event)
{
    QMessageBox::StandardButton resBtn = QMessageBox::question(
        this, tr("Exit Confirmation"), tr("Are you sure?"), QMessageBox::No | QMessageBox::Yes, QMessageBox::Yes);

    if (resBtn != QMessageBox::Yes)
    {
        event->ignore();
    }
    else
    {
        event->accept();
    }
}
