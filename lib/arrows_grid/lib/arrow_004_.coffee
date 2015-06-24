
{c, React, rr, shortid, assign, update, __react__root__} = require('../../__boiler__plate__.coffee')()

{p, div, h1, h2, h3, h4, h5, h6, span, svg, circle, rect, ul, line, li, ol, code, a, input, defs, clipPath, linearGradient, stop, g, path, d, polygon, image, pattern, filter, feBlend, feOffset, polyline, feGaussianBlur, feMergeNode, feMerge, radialGradient} = React.DOM

arrow = rr

    componentWillUnmount: ->
        clearInterval @interval_000

    getInitialState: ->
        arrow_stroke: 'red'
        fill_stroke: 'blue'
        rotate: 0


    shuffle_stroke: ->
        start = new Date().getTime()
        interval_000 = setInterval =>
            now = new Date().getTime()
            scaling_factor = .10
            delta = start - now
            delta *= scaling_factor
            @setState
                arrow_stroke: "hsl(#{(delta + 90) % 360}, 99%, 77%)"
                fill_stroke: "hsl(#{(delta + 210) % 360}, 99%, 77%)"
                rotate: (delta + 120) % 360
        , 1

    componentDidMount: ->
        rect = React.findDOMNode(@).getBoundingClientRect()
        @setState
            rect_width: rect.width
            rect_height: rect.height
        @shuffle_stroke()

    render: ->
        c 'section', @props.section
        svg
            width: '100%'
            height: '100%'
            onMouseOver: => c @props.cursor
            #onMouseLeave:
            ,
            g
                #translate(#{rect.width / 3})
                transform: "rotate(#{@state.rotate}, #{rect.width * .5}, #{rect.height * .5})"
                ,
                path
                    stroke: @state.arrow_stroke
                    fill: @state.fill_stroke
                    strokeWidth: 1
                    d: "M #{rect.width * .5} #{rect.height * .45} L #{rect.width * .85} #{rect.height * .5} L #{rect.width * .5} #{rect.height * .55} Z"

module.exports = -> arrow