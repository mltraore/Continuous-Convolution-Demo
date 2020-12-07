import QtQuick 2.0
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

Item {
   id: rootItem
   property alias pulseWave: spinRectId
   property int amPulse: 1
   property int wiPulse: 2
   property int dePulse: 0

   Rectangle{
     id: spinRectId
     width: parent.width
     height: parent.height

     Column{
       id: rootColumn
       anchors.left: parent.left
       anchors.right: parent.right
       anchors.top: parent.top
       anchors.bottom: parent.bottom
       anchors.topMargin:100
       spacing: 100

       Row{
          spacing: 45
          x: rootColumn.x + 10
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
              onValueChanged: {
                   spinRectId.updateSignal(amplitude.value, width.value, delay.value)
                   amPulse = amplitude.value
              }
          }
       }

       Row{
          spacing: 45
          x: rootColumn.x + 44
          Label{
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            text: "Width:"
            font.pixelSize: 17
          }

          SpinBox{
              id: width
              from:1
              to:10
              value: 2
              onValueChanged: {
                  spinRectId.updateSignal(amplitude.value, width.value, delay.value)
                  wiPulse = width.value
              }
          }
       }

       Row{
          spacing: 45
          x: rootColumn.x + 46
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
                  spinRectId.updateSignal(amplitude.value, width.value, delay.value)
                  dePulse = delay.value
              }
          }
       }

     }
     function updateSignal(a, w, d){
         sig.clear()
         ccdemo.pul(a, w, d)
         var c = ccdemo.sig_pul_y
         var t = ccdemo.sig_pul_t

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
