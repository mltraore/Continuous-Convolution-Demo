import QtQuick 2.0
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

Item {
    id: rootItem
    Rectangle{
     id: spinRectId
     width:   parent.width
     height:  parent.height

     Row{
        spacing: 40
        x: spinRectId.x + 60
        y: spinRectId.y + 150


        Label{
          height: parent.height
          verticalAlignment: Text.AlignVCenter
          text: "Area:"
          font.pixelSize: 17
        }

        SpinBox{
            from:-10
            to:10
        }
     }


     Row{
        spacing: 35
        x: spinRectId.x + 60
        y: spinRectId.y + 350
        Label{
          height: parent.height
          verticalAlignment: Text.AlignVCenter
          text: "Delay:"
          font.pixelSize: 17
        }

        SpinBox{
            from:-10
            to:10
        }
     }

    }
}
