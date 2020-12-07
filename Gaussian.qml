import QtQuick 2.0
import QtQuick.Controls 2.14

Item {   
    id: rootItem
    property alias gaussianWave: spinRectId
    property int  scaGaus: 1
    property real expGaus: 0.5
    property int lenGaus: 10
    property int deGaus: 0

    Rectangle{
     id: spinRectId
     width:   parent.width
     height:  parent.height

     Row{
        spacing: 15
        x: spinRectId.x + 65
        y: spinRectId.y + 80
        Label{
          height: parent.height
          verticalAlignment: Text.AlignVCenter
          text: "Scaling factor:"
          font.pixelSize: 17
        }

        SpinBox{
            id: scaleFactor
            from:-10
            to:10
            value: 1
            onValueChanged: {
                spinRectId.updateSignal(scaleFactor.value, mm.spim.value/100, length.value, delay.value)
                scaGaus = scaleFactor.value
            }
        }
     }

     Row{
        spacing: 15
        x: spinRectId.x + 5
        y: spinRectId.y + 220

        Label{
          id: lbl
          height:  parent.height
          verticalAlignment: Text.AlignVCenter
          text: "Exponential Constant:"
          font.pixelSize: 17
        }


        // Adjust CustomSpinBox value in CustomSpinBox qml file [from to]
        CustomSpinBox{
            id: mm
            y: lbl.y - 20
            x: lbl.x + 185

            realValue: 0.5
            realStepSize: 0.05
            spim.onValueChanged: {
               spinRectId.updateSignal(scaleFactor.value, spim.value/100, length.value, delay.value)
               expGaus = spim.value/100
            }
        }

/*
        SpinBox{
          id: expConst
          from:-10
          to:10
          onValueChanged: {
              spinRectId.updateSignal(scaleFactor.value, expConst.value, length.value, delay.value)
              expGaus = expConst.value
          }
        }
 */

     }

     Row{
        spacing: 15
        x: spinRectId.x + 115
        y: spinRectId.y + 320

        Label{
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            text: "Length:"
            font.pixelSize: 17
        }

        SpinBox{
            id: length
            from: 1
            to: 10
            value: 10
            onValueChanged: {
                spinRectId.updateSignal(scaleFactor.value,mm.spim.value/100, length.value, delay.value)
                lenGaus = length.value
            }
        }
     }

     Row{
        spacing: 15
        x: spinRectId.x + 125
        y: spinRectId.y + 440

        Label{
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            text: "Delay:"
            font.pixelSize: 17
        }

        SpinBox{
            id: delay
            from: -10
            to: 10
            value: 0
            onValueChanged: {
                spinRectId.updateSignal(scaleFactor.value, mm.spim.value/100, length.value, delay.value)
                deGaus = delay.value
            }
        }
     }

     function updateSignal(sc, ex, le, de){
         sig.clear()
         ccdemo.gauss(sc, ex, le, de)
         var c = ccdemo.sig_gaus_y
         var t = ccdemo.sig_gaus_t

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
