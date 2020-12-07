import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import QtCharts 2.14

ApplicationWindow{
 width: 400
 height: 300
 x: 700
 y: 500

CustomSpinBox{
     realValue: 1.0
     realStepSize: 0.05
     spim.onValueChanged: {
        console.log(spim.value/100)
     }
  }

}
