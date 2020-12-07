import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import QtCharts 2.14


ApplicationWindow {
    id: rootGetx
    visible: true
    maximumWidth: 1000
    minimumWidth: 1000

    maximumHeight: 700
    minimumHeight: 700

    //property Cconvdemo cconv: Cconvdemo{}

    title: qsTr("Get x(t)")

    property alias sigx_x: sig.axisX

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
                            console.log(rec1ComboboxId.currentIndex)
                            switch(currentIndex) {
                            case 0:
                                cosine.visible   = true
                                expt.visible     = false
                                gaussian.visible = false
                                impulse.visible  = false
                                pulse.visible    = false
                                sine.visible     = false

                                cosine.wave.updateSignal(cosine.amp, cosine.per, cosine.pha, cosine.len, cosine.del)

                                break
                            case 1:
                                cosine.visible   = false
                                expt.visible     = true
                                gaussian.visible = false
                                impulse.visible  = false
                                pulse.visible    = false
                                sine.visible     = false

                                expt.exponentialWave.updateSignal(expt.scExpo, expt.exExpo, expt.leExpo, expt.deExpo, expt.caExpo)

                                break
                            case 2:
                                cosine.visible   = false
                                expt.visible     = false
                                gaussian.visible = true
                                impulse.visible  = false
                                pulse.visible    = false
                                sine.visible     = false

                                gaussian.gaussianWave.updateSignal(gaussian.scaGaus, gaussian.expGaus, gaussian.lenGaus, gaussian.deGaus)

                                break
                            case 3:
                                cosine.visible   = false
                                expt.visible     = false
                                gaussian.visible = false
                                impulse.visible  = true
                                pulse.visible    = false
                                sine.visible     = false

                                sig.clear()


                                break
                            case 4:
                                cosine.visible   = false
                                expt.visible     = false
                                gaussian.visible = false
                                impulse.visible  = false
                                pulse.visible    = true
                                sine.visible     = false

                                pulse.pulseWave.updateSignal(pulse.amPulse, pulse.wiPulse, pulse.dePulse)

                                break
                            case 5:
                                cosine.visible   = false
                                expt.visible     = false
                                gaussian.visible = false
                                impulse.visible  = false
                                pulse.visible    = false
                                sine.visible     = true

                                sine.sineWave.updateSignal(sine.amSine, sine.peSine, sine.phSine, sine.leSine, sine.deSine)

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
                        animationOptions: ChartView.SeriesAnimations
                        legend.visible: true
                        legend.markerShape: Legend.MarkerShapeFromSeries
                        legend.alignment: Qt.AlignTop
                        margins.top: 0
                        margins.bottom: 0
                        margins.left: 0
                        margins.right: 0

                        ValueAxis{
                            id: axisX
                            visible: true
                            gridVisible: false
                        }

                        ValueAxis{
                            id: axisY
                            visible: true
                            gridVisible: false
                        }


                        LineSeries {
                            id: sig
                            // TODO:  lineSeries properties: name, width ...
                            axisX: axisX
                            axisY: axisY
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
                        id: expt
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
                        visible: true
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
                       onClicked: {
                            rootGetx.close();
                       }
                       }

                    Button{
                       text: "Cancel"
                       }
                   }
            }
        }
    }
}
