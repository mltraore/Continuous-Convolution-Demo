import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import QtCharts 2.14

ApplicationWindow{
    id: root
    width: 1200
    height: 720
    visible: true
    title: qsTr("Continuous Convolution Demo")
    MenuBar{
        id: menuBarId
        x: 0 ; y:0
        width: parent.width

        Menu{
            title: qsTr("&Plot  Options")
            MenuItem {
                id: tutoId
                text: qsTr("Tutorial  Mode")
                checkable: true
                checked: false

                indicator: Rectangle {
                            implicitHeight: 26
                            implicitWidth: 26
                            x: parent.width - 35
                            y: parent.height / 2 - height / 2
                            radius: 3
                            border.color: "black"
                            Rectangle {
                                x: 6
                                y: 6
                                width: 14
                                height: 14
                                radius: 2
                                color:   tutoId.down ? "#ffffff" : "#000000"
                                visible: tutoId.checked
                            }
                        }
                contentItem: Text {
                    text: tutoId.text
                    font: tutoId.font
                    opacity: enabled ? 1.0 : 0.3
                    color: "black"
                    verticalAlignment: Text.AlignVCenter
                    rightPadding: tutoId.indicator.width + tutoId.spacing
                  }

 //   TODO:  if checked
                onCheckedChanged: {
                      if (checked){
                         convolutionId.visible = false
                         getOutputId.visible  = true
                      }else{
                         convolutionId.visible = true
                         getOutputId.visible  = false
                      }
                }

            }

            MenuSeparator{}

            MenuItem {
                id: conserveId
                text: qsTr("Conserve  Space")
                checkable: true
                checked: false

                indicator: Rectangle {
                            implicitHeight: 26
                            implicitWidth: 26
                            x: parent.width - 35
                            y: parent.height / 2 - height / 2
                            radius: 3
                            border.color: "black"
                            Rectangle {
                                x: 6
                                y: 6
                                width: 14
                                height: 14
                                radius: 2
                                color:   conserveId.down ? "#ffffff" : "#000000"
                                visible: conserveId.checked
                            }
                        }
                contentItem: Text {
                    text: conserveId.text
                    font: conserveId.font
                    opacity: enabled ? 1.0 : 0.3
                    color: "black"
                    verticalAlignment: Text.AlignVCenter
                    rightPadding: conserveId.indicator.width + conserveId.spacing
                  }

// TODO if checked

                onCheckedChanged: {
                    if(checked){
                        inputRectId.visible = false
                        framesId.width = root.width
                    }else{
                        inputRectId.visible = true
                        framesId.width = root.width - inputRectId.width
                    }

                   }

            }

            MenuItem {
                id: gridOnId
                text: qsTr("Grid  On")
                checkable: true
                checked: false

                indicator: Rectangle {
                            implicitHeight: 26
                            implicitWidth: 26
                            x: parent.width - 35
                            y: parent.height / 2 - height / 2
                            radius: 3
                            border.color: "black"
                            Rectangle {
                                x: 6
                                y: 6
                                width: 14
                                height: 14
                                radius: 2
                                color:   gridOnId.down ? "#ffffff" : "#000000"
                                visible: gridOnId.checked
                            }
                        }
                contentItem: Text {
                    text: gridOnId.text
                    font: gridOnId.font
                    opacity: enabled ? 1.0 : 0.3
                    color: "black"
                    verticalAlignment: Text.AlignVCenter
                    rightPadding: gridOnId.indicator.width + gridOnId.spacing
                  }


// TODO if checked
                onCheckedChanged: {
                      if(checked)
                         chart1X.gridVisible = true
                      else
                         chart1X.gridVisible = false
                }

            }

            Action{ text: qsTr("&Reset  Axes")}
            Action{ text: qsTr("Set  &t  Values...")}
            Action{ text: qsTr("&Set  Line  Width...")}
            Action{ text: qsTr("&Take  Screen-shot...")}

            MenuItem {
                id: showMenuId
                text: qsTr("Show  Menu")
                checkable: true
                checked: false

                indicator: Rectangle {
                            implicitHeight: 26
                            implicitWidth: 26
                            x: parent.width - 35
                            y: parent.height / 2 - height / 2
                            radius: 3
                            border.color: "black"
                            Rectangle {
                                x: 6
                                y: 6
                                width: 14
                                height: 14
                                radius: 2
                                color:   showMenuId.down ? "#ffffff" : "#000000"
                                visible: showMenuId.checked
                            }
                        }
                contentItem: Text {
                    text: showMenuId.text
                    font: showMenuId.font
                    opacity: enabled ? 1.0 : 0.3
                    color: "black"
                    verticalAlignment: Text.AlignVCenter
                    rightPadding: showMenuId.indicator.width + showMenuId.spacing
                  }

 // TODO if checked

              }


            }

        Menu{
            title: qsTr("&Help")
            Action{ text: qsTr("&Contents...")}
        }

    }

    Rectangle{
       y:menuBarId.height
       id: inputRectId
       width: parent.width/2 - 50
       height: parent.height - menuBarId.height
       color: "lightblue"
       anchors.right: parent.right
       visible: true
       Column{
           spacing: 20
           topPadding: 50

           Row{
              leftPadding: 120
              spacing: 190
              Label{
                text: qsTr("Input")
              }
              Label{
                text: qsTr("Impulse Response")
              }
           }

           Row{
               leftPadding: 20
               spacing: 30

               Rectangle{
                   id: inputId
                   width: inputRectId.width/2.3
                   height: inputRectId.height/4

                   ChartView {
                           id: inputChart
                           anchors.fill: parent
                           antialiasing: true
                           animationOptions: ChartView.SeriesAnimations
                           legend.visible: true
                           legend.markerShape: Legend.MarkerShapeFromSeries
                           legend.alignment: Qt.AlignTop
                           margins.top: 0
                           margins.bottom: 0
                           margins.left: 0
                           margins.right: 0

                           ValueAxis {
                               id: inputChartX
                               visible: true
                               gridVisible: chart1X.gridVisible
                           }

                           ValueAxis {
                               id: inputChartY
                               visible: true
                               gridVisible: chart1X.gridVisible
                            }

                            LineSeries {
                                 id: inputSignal
                                 name: "Input Signal"
                                 width: 0.5
                                 axisX: inputChartX
                                 axisY: inputChartY
                             }

/****************************************/
                   }


               }

               Rectangle{
                   id: responseId
                   width: inputRectId.width/2.3
                   height: inputRectId.height/4

                   ChartView {
                           id: responseChart
                           anchors.fill: parent
                           antialiasing: true
                           animationOptions: ChartView.SeriesAnimations
                           legend.visible: true
                           legend.markerShape: Legend.MarkerShapeFromSeries
                           legend.alignment: Qt.AlignTop
                           margins.top: 0
                           margins.bottom: 0
                           margins.left: 0
                           margins.right: 0

                           ValueAxis {
                               id: responseChartX
                               visible: true
                               gridVisible: chart1X.gridVisible
                           }

                           ValueAxis {
                               id: responseChartY
                               visible: true
                               gridVisible: chart1X.gridVisible
                            }

                            LineSeries {
                                 id: responseSignal
                                 name: "Response Signal"
                                 //width: 0.5
                                 axisX: responseChartX
                                 axisY: responseChartY

                                /* Data{
                                   id: it
                                 }

                                 Component.onCompleted: {
                                    responseSignal = it.sign
                                 }*/
                             }
                   }
               }
           }

           Row{
               leftPadding: 90
               spacing: 170

               Button{
                   text: qsTr("Get x(t)")
                   layer.format: ShaderEffectSource.RGBA
                   onClicked: {
                       var component = Qt.createComponent("get_x_t.qml")
                       var window    = component.createObject(root)
                       window.show()
                   }
               }

               Button{
                   text: qsTr("Get h(t)")
                   layer.format: ShaderEffectSource.RGBA
                   onClicked: {
                       //var component = Qt.createComponent("get_h_t.qml")
                       var component = Qt.createComponent("get_h.qml")
                       var window    = component.createObject(root)
                       window.show()


                   }
               }
           }

           Row{
               leftPadding: 90
               spacing: 175
               RadioButton {
                       id: controrl
                       checked: true
                       text: qsTr("Flip x(t)")

               }
               RadioButton {
                       text: qsTr("Flip h(t)")
                   }
           }

           Row{
             leftPadding: 20
             Rectangle{
              id: startBoxId
              width: inputRectId.x/1.28
              height: inputRectId.height/4 + 20
              border.color: "black"
              color: "#a9a9a9"
              Text {
                    anchors.fill: parent
                    text: qsTr("To Start\n\n Pick both an input signal and \n an impulse response. \n\nThen drag pointers or use the arrow keys \nto slide the flipped signal around.\n")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 19
              }
             }

           }

           Row{
               leftPadding: 130
               spacing: 100
               Button{
                   text: qsTr("Close")
                    onClicked: root.close();
               }
               Button{
                   text: qsTr("Help")
                   onClicked: {
// TODO:  Function of Help Button

                           inputSignal.clear()
                           var c = ccdemo.sig_getx_y
                           var t = ccdemo.sig_getx_t
                           for(var i = 0; i< c.length; i++){
                               inputSignal.append(t[i], c[i])
                           }
                           inputChartX.max = t[t.length-1]
                           inputChartX.min = t[0]
                           inputChartY.max = Math.max.apply(null, c)
                           inputChartY.min = Math.min.apply(null, c)

                   }
               }
           }
       }

    }

    Rectangle{
        id: framesId
        y: inputRectId.y
        width:  root.width - inputRectId.width
        height: inputRectId.height
        color: "#d3d3d3"

        Frame{
          id: signalId
          x: parent.x
          y: parent.y
          width: parent.width - 50
          height: parent.height/3 - 35
          anchors.top: parent.top
          anchors.topMargin: 25
          anchors.horizontalCenter: parent.horizontalCenter

          ChartView {
                  id: chartSignal1
                  anchors.fill: parent
                  antialiasing: true
                  animationOptions: ChartView.SeriesAnimations
                  legend.visible: true
                  legend.markerShape: Legend.MarkerShapeFromSeries
                  legend.alignment: Qt.AlignTop
                  margins.top: 0
                  margins.bottom: 0
                  margins.left: 0
                  margins.right: 0


                  ValueAxis {
                     id: chart1X
                     visible: true
                     gridVisible: false
                  }

                  ValueAxis {
                     id: chart1Y
                     visible: true
                     gridVisible: chart1X.gridVisible
                   }

                   LineSeries {
                        id: originalSignal
                        name: "Original Signal"
                        width: 0.5
                        axisX: chart1X
                        axisY: chart1Y
                    }

          }



        }

        Frame{
          id: multiplicationId
          x: parent.x
          y: parent.y + signalId.height
          width: parent.width - 50
          height: parent.height/3 - 35
          anchors.top: signalId.bottom
          anchors.topMargin: 25
          anchors.horizontalCenter: parent.horizontalCenter

          ChartView {
                  id: chartSignal2
                  anchors.fill: parent
                  antialiasing: true
                  animationOptions: ChartView.SeriesAnimations
                  legend.visible: true
                  legend.markerShape: Legend.MarkerShapeFromSeries
                  legend.alignment: Qt.AlignTop
                  margins.top: 0
                  margins.bottom: 0
                  margins.left: 0
                  margins.right: 0

                  ValueAxis {
                      id: chart2X
                      visible: true
                      gridVisible: chart1X.gridVisible
                  }

                  ValueAxis {
                      id: chart2Y
                      visible: true
                      gridVisible: chart1X.gridVisible
                   }

                   LineSeries {
                        id: multiplicationSignal
                        name: "Multiplication"
                        width: 0.5
                        axisX: chart2X
                        axisY: chart2Y
                    }
          }


        }

        Frame{
          id: convolutionId
          x: parent.x
          y: multiplicationId.y + multiplicationId.height
          width: parent.width - 50
          height: parent.height/3 - 35
          anchors.top: multiplicationId.bottom
          anchors.topMargin: 25
          anchors.horizontalCenter: parent.horizontalCenter


          ChartView {
                  id: chartSignal3
                  anchors.fill: parent
                  antialiasing: true
                  animationOptions: ChartView.SeriesAnimations
                  legend.visible: true
                  legend.markerShape: Legend.MarkerShapeFromSeries
                  legend.alignment: Qt.AlignTop
                  margins.top: 0
                  margins.bottom: 0
                  margins.left: 0
                  margins.right: 0

                  ValueAxis {
                      id: chart3X
                      visible: true
                      gridVisible: chart1X.gridVisible
                  }

                  ValueAxis {
                      id: chart3Y
                      visible: true
                      gridVisible: chart1X.gridVisible
                   }

                   LineSeries {
                        id: convolutionSignal
                        name: "Convolution"
                        width: 0.5
                        axisX: chart3X
                        axisY: chart3Y
                    }
          }

        }

     }


 /////////////


    Button{
        id: getOutputId
      visible: false
      width: 220
      height: 60
      x:convolutionId.width/2 - 100  ; y:convolutionId.y +  convolutionId.height/2 + 10
      text: qsTr("Get Output")

// TODO: Return to convolutionId frame

      onClicked: {
          getOutputId.visible = false
          convolutionId.visible = true
          tutoId.checked = false

      }
    }



    //var c = ccdemo.sig_cos_y
    //var t = ccdemo.sig_cos_t


    }
