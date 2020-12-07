import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import QtCharts 2.14


ApplicationWindow {
    visible: true
    maximumWidth: 1000
    minimumWidth: 1000

    maximumHeight: 700
    minimumHeight: 700

    title: qsTr("Get h(t)")

    Rectangle{
        id: rootRec
        width: parent.width
        height: parent.height
        color:"#dcdcdc"


        Column{
            id: rootColumn

            Rectangle{
                id: recSigType
                width: rootRec.width
                height: rootRec.height/11
                color: "#a9a9a9"

                Row{
                    id:rowSigType
                    anchors.centerIn: parent
                    spacing: 12

                    Label{
                        id: rec1LabelId
                        height: recSigType.height
                        font.pixelSize: 17
                        text: "Signal: "
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }

                    ComboBox{
                        id: rec1ComboboxId
                        height: recSigType.height / 2

                        width: recSigType.width/5
                        font.pixelSize: 15
                        focusPolicy: Qt.TabFocus
                        font.weight: Font.Normal
                        anchors.top: parent.top
                        anchors.topMargin: 16
                        currentIndex: 0
                        model:["Cosine","Exponential","Gaussian","Impulse","Pulse","Sine"]

                        onCurrentValueChanged: {
                            switch(currentIndex) {
                            case 0:
                                cosine.visible   = true
                                expo.visible     = false
                                gaussian.visible = false
                                impulse.visible  = false
                                pulse.visible    = false
                                sine.visible     = false
                                break
                            case 1:
                                cosine.visible   = false
                                expo.visible     = true
                                gaussian.visible = false
                                impulse.visible  = false
                                pulse.visible    = false
                                sine.visible     = false
                                break
                            case 2:
                                cosine.visible   = false
                                expo.visible     = false
                                gaussian.visible = true
                                impulse.visible  = false
                                pulse.visible    = false
                                sine.visible     = false
                                break
                            case 3:
                                cosine.visible   = false
                                expo.visible     = false
                                gaussian.visible = false
                                impulse.visible  = true
                                pulse.visible    = false
                                sine.visible     = false
                                break
                            case 4:
                                cosine.visible   = false
                                expo.visible     = false
                                gaussian.visible = false
                                impulse.visible  = false
                                pulse.visible    = true
                                sine.visible     = false
                                break
                            case 5:
                                cosine.visible   = false
                                expo.visible     = false
                                gaussian.visible = false
                                impulse.visible  = false
                                pulse.visible    = false
                                sine.visible     = true
                                break
                            default:
                                console.log("NOOOOOOOOOOOO")
                            }
                        }
                    }
                }
            }

            Row {

                Rectangle {
                    id: recChart
                    width: rootRec.width / 2 + 150
                    height: rootRec.height - recSigType.height - 100

                    ChartView {
                        id: chart
                        antialiasing: true
                        anchors.fill: parent

                        LineSeries {

                        }

                    }
                }

                Rectangle {
                    id: recSigsInput
                    width: rootRec.width - recChart.width
                    height: recChart.height
                    color: "lightBlue"

                    Cosine{
                        id: cosine
                        visible: false
                    }


                    Exponential {
                        id: expo
                        visible: false
                    }

                    Gaussian{
                        id: gaussian
                        visible: false
                    }


                    Impulse{
                        id: impulse
                        visible: false
                    }


                    Pulse{
                        id: pulse
                        visible: false
                    }


                    Sine {
                        id: sine
                        visible: false
                    }


                }

            }
// FOOTER
            Row{
               spacing:rootRec.width/4  - 10
               leftPadding: 120
               topPadding: (rootRec.height - recChart.height - recSigType.height - 35)/2


               Label{
                    text: "Click inside plot area to rescale axis"
                    font.pixelSize: 22
                    }

               Row{
                    spacing:30

                    Button{
                       text: "OK"

                       }

                    Button{
                       text: "Cancel"

                       }
                   }

            }

        }
    }
}
