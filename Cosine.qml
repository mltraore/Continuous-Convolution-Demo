import QtQuick 2.0
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

Item {
    id: rootItem
    property alias wave: spinRectId
    property int amp: 1
    property int per: 10
    property int pha: 0
    property int len: 10
    property int del: 0

    Rectangle{
     id: spinRectId
     width:   parent.width
     height:  parent.height

     Row{
        spacing: 45
        x: spinRectId.x + 20
        y: spinRectId.y + 80

        Label{
          height: parent.height
          verticalAlignment: Text.AlignVCenter
          text: "Amplitude:"
          font.pixelSize: 17
        }

        SpinBox{
            id: amplitude
            from:-10
            to:10
            value:1
            //signal ampChanged(int a,  int p, int f, int l, int d)
            onValueChanged: {
                //ccdemo.cos(amplitude.value, period.value, phase.value, length.value, delay.value)
                //amplitude.ampChanged.connect(spinRectId.updateSignal)
                //amplitude.ampChanged(amplitude.value, period.value, phase.value, length.value, delay.value)

                amp = amplitude.value
                spinRectId.updateSignal(amplitude.value, period.value, phase.value, length.value, delay.value)


            }
        }
     }

     Row{
        spacing: 45
        x: spinRectId.x + 50
        y: spinRectId.y + 170
        Label{
          height: parent.height
          verticalAlignment: Text.AlignVCenter
          text: "Period:"
          font.pixelSize: 17
        }

        SpinBox{
            id: period
            from:1
            to:10
            value: 10
            onValueChanged: {
                spinRectId.updateSignal(amplitude.value, period.value, phase.value, length.value, delay.value)
                per = period.value
            }
        }
     }

     Row{
        spacing: 45
        x: spinRectId.x + 53
        y: spinRectId.y + 260
        Label{
          height: parent.height
          verticalAlignment: Text.AlignVCenter
          text: "Phase:"
          font.pixelSize: 17
        }

        SpinBox{
            id: phase
            from:-10
            to:10
            value:0
            onValueChanged: {                
                spinRectId.updateSignal(amplitude.value, period.value, phase.value, length.value, delay.value)
                pha = phase.value
            }
        }
     }


     Row{
        spacing: 45
        x: spinRectId.x + 45
        y: spinRectId.y + 350
        Label{
          height: parent.height
          verticalAlignment: Text.AlignVCenter
          text: "Length:"
          font.pixelSize: 17
        }

        SpinBox{
            id: length
            from:1
            to:10
            value:10
            onValueChanged: {
                spinRectId.updateSignal(amplitude.value, period.value, phase.value, length.value, delay.value)
                len = length.value
            }
        }
     }


     Row{
        spacing: 45
        x: spinRectId.x + 55
        y: spinRectId.y + 440
        Label{
          height: parent.height
          verticalAlignment: Text.AlignVCenter
          text: "Delay:"
          font.pixelSize: 17
        }

        SpinBox{
            id: delay
            from:-10
            to:10
            value: 0
            onValueChanged: {
                spinRectId.updateSignal(amplitude.value, period.value, phase.value, length.value, delay.value)
                del = delay.value
            }
        }
     }

     function updateSignal(a, p, f, l, d){
         sig.clear()

         ccdemo.cos(a, p, f, l, d)
         var c = ccdemo.sig_cos_y
         var t = ccdemo.sig_cos_t

         ccdemo.getxx(c, t)
         ccdemo.gethh(c, t)

         for(var i = 0; i< c.length; i++){
             sig.append(t[i], c[i])
         }
         axisX.max = t[t.length-1]
         axisX.min = t[0]

         axisY.max = Math.max.apply(null, c)
         axisY.min = Math.min.apply(null, c)
     }
    }
}
