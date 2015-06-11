module.exports = ->
    c = -> console.log.apply console, arguments
    React = require("react")
    PureRenderMixin = require('react/addons').addons.PureRenderMixin
    {p, div, h1, h2, h3, h4, h5, h6, span, svg, circle, rect, ul, line, li, ol, code, a, input, defs, clipPath, linearGradient, stop, g, path, d} = React.DOM
    rr = -> React.createFactory(React.createClass.apply(React, arguments))
    shortid = require('shortid')

# this implementation will do another svg track.  this time 5 pixel slices like an integer will be drawn out, and each will be associated with the same click handler which will accept some kind of index to pass which will mean that state can be set by clicking on the object itself.
# still do range dial, it will move range dial. 
# instrumentation and controls.

    rr
        render: ->
            clipId = shortid.generate()
            clipId2 = shortid.generate()
            style = (a) ->
                position: 'absolute'

            height = @props.height
            width = @props.width
            if (width / 100) >= 2 then padX = (width / 100) else padX = 2
            if (height / 100) >= 2 then padY = (height / 100) else padY = 2

            div # container
                style: style()
                ,
                svg
                    width: @props.width + padX
                    height: @props.height + padY
                    style:
                        #background: 'lightgrey'
                        position: 'absolute'
                    ,
                    defs
                        linearGradient
                            id: "grad1"
                            x1: "0%"
                            y1: "0%"
                            x2: "100%"
                            y2: "100%"
                            stop
                                offset: "0%"
                                style: 
                                    stopColor:"rgb(255,255,0)"
                                    stopOpacity: 1
                            stop
                                offset: "100%"
                                style:
                                    stopColor: "rgb(255,0,0)"
                                    stopOpacity: 1
                        clipPath
                            id: clipId
                            ,
                            rect
                                x: 0
                                y: 0
                                width: ((width + padX)/ 100) * @props.range
                                height: height + padY # fix this
                        clipPath
                            id: clipId2
                            ,
                            rect
                                x: (((width + padX) / 100) * @props.range)
                                y: 0
                                width: (width + padX) - (((width + padX)/ 100) * @props.range)
                                height: height + padY # fix this
                    path
                        d: "M#{height / 2} 0
                            A #{height / 2} #{height / 2}, 0, 0, 0, #{height / 2} #{height}
                            H #{width - (height / 2)}
                            A #{height / 2} #{height / 2}, 0, 0, 0, #{width - (height / 2)} 0
                            "
                        fill: 'black'
                        clipPath: "url(##{clipId2})"
                    path
                        d: "M#{height / 2} 0
                            A #{height / 2} #{height / 2}, 0, 0, 0, #{height / 2} #{height}
                            H #{width - (height / 2)}
                            A #{height / 2} #{height / 2}, 0, 0, 0, #{width - (height / 2)} 0
                            "
                        fill: 'url(#grad1)'
                        clipPath: "url(##{clipId})"



