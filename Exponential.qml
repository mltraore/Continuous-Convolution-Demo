import QtQuick 2.0
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

Item {
    id: rootItem
    property alias exponentialWave: spinRectId
    property int scExpo: 1
    property real exExpo: 10
    property int leExpo: 10
    property int deExpo: 0
    property string caExpo: 'causal'

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
                spinRectId.updateSignal(scaleFactor.value, custom.spim.value/100, length.value, delay.value, caExpo)
                scExpo = scaleFactor.value
            }
        }
     }

     Row{
        spacing: 15
        x: spinRectId.x + 5
        y: spinRectId.y + 180

        Label{
            id: lbl
          height:  parent.height
          verticalAlignment: Text.AlignVCenter
          text: "Exponential Constant:"
          font.pixelSize: 17
        }


     CustomSpinBox{
         id: custom
         y: lbl.y - 20
         x: lbl.x + 185

         realValue: 0.5
         realStepSize: 0.05
         spim.onValueChanged: {
             spinRectId.updateSignal(scaleFactor.value, custom.spim.value/100, length.value, delay.value, caExpo)
             exExpo = custom.spim.value/100
         }
     }


     }

     Row{
        spacing: 15
        x: spinRectId.x + 115
        y: spinRectId.y + 240

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
                spinRectId.updateSignal(scaleFactor.value, custom.spim.value/100, length.value, delay.value, caExpo)
                leExpo = length.value
            }
        }
     }

     Row{
        spacing: 15
        x: spinRectId.x + 125
        y: spinRectId.y + 320

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
                spinRectId.updateSignal(scaleFactor.value, custom.spim.value/100, length.value, delay.value, caExpo)
                deExpo = delay.value
            }
        }
     }

     Label{
         id: label
         x: spinRectId.x + 45
         y: spinRectId.y + 385
         text: "Causality:"
         font.pixelSize: 17
     }

     Rectangle{
         id: causalityId
         width: 330
         height: 105
         x: label.x - 35
         y: label.y + 35
         color: "#c0c0c0"
         border.color: "black"
         border.width: 2

         Row{
            spacing: 30
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            RadioButton {
                    id: controrl
                    checked: true
                    text: qsTr("Causal")
                    onCheckedChanged: {
                        if(checked){
                            caExpo = 'causal'
                            spinRectId.updateSignal(scaleFactor.value, custom.spim.value/100, length.value, delay.value, caExpo)
                            console.log(caExpo)
                        }else{
                            caExpo = 'noncausal'
                            spinRectId.updateSignal(scaleFactor.value, custom.spim.value/100, length.value, delay.value, caExpo)
                            console.log(caExpo)
                        }
                    }
            }
            RadioButton {
                    text: qsTr("Noncausal")
                }
         }
     }

     function updateSignal(sc, ex, le, de, ca){
         sig.clear()
         ccdemo.expo(sc, ex, le, de, ca)
         var c = ccdemo.sig_exp_y
         var t = ccdemo.sig_exp_t

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
