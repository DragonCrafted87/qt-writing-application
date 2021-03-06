#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QConstOverload>
#include <QMainWindow>
#include <QObject>

class QCloseEvent;
class QWidget;

QT_BEGIN_NAMESPACE
namespace Ui
{
    class MainWindow;
}
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget * parent = nullptr);
    ~MainWindow();

private slots:
    static void newDocument();
    static void openDocument();
    static void saveDocument();

private:
    void closeEvent(QCloseEvent * event);

    Ui::MainWindow * ui;
};
#endif
