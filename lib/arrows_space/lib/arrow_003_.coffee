
{c, React, rr, shortid, assign, update, __react__root__} = require('../../__boiler__plate__.coffee')()

{p, div, h1, h2, h3, h4, h5, h6, span, svg, circle, rect, ul, line, li, ol, code, a, input, defs, clipPath, linearGradient, stop, g, path, d, polygon, image, pattern, filter, feBlend, feOffset, polyline, feGaussianBlur, feMergeNode, feMerge, radialGradient, text} = React.DOM

arrow = rr

    componentWillUnmount: ->
        clearInterval @interval_000

    shuffle_stroke: ->
        start = new Date().getTime()
        @interval_000 = setInterval =>
            now = new Date().getTime()
            scaling_factor = .10
            delta = start - now
            delta *= scaling_factor
            @setState
                arrow_stroke: "hsl(#{(delta + 90) % 360}, 99%, 77%)"
                fill_stroke: "hsl(#{(delta + 210) % 360}, 99%, 77%)"
                rotate: delta % 360
        , 1

    componentDidMount: ->
        window.addEventListener 'resize', (e) =>
            boundingRect = React.findDOMNode(@).getBoundingClientRect()
            @setState
                rect_width: boundingRect.width
                rect_height: boundingRect.height
            @shuffle_stroke()
        boundingRect = React.findDOMNode(@).getBoundingClientRect()
        @setState
            rect_width: boundingRect.width
            rect_height: boundingRect.height
        @shuffle_stroke()

        c 'localStorage', localStorage

    render: ->
        if @state?.rect_width?
            svg
                onMouseOver: => @setState({info: on})
                onMouseLeave: => @setState({info: off})
                onClick: => @props.focus_cell_selection(@props.section, @props.cursor)
                width: '100%'
                height: '100%'
                ,
                g
                    #translate(#{rect.width / 3})
                    transform: "rotate(#{@state.rotate}, #{@state.rect_width * .5}, #{@state.rect_height * .5})"
                    ,
                    path
                        stroke: @state.arrow_stroke
                        fill: @state.fill_stroke
                        strokeWidth: 1
                        d: "M #{@state.rect_width * .5} #{@state.rect_height * .45} L #{@state.rect_width * .85} #{@state.rect_height * .5} L #{@state.rect_width * .5} #{@state.rect_height * .55} Z"
                if @state.info is on
                    g
                        opacity: 0.5
                        fill: 'green'
                        ,
                        text
                            x: "20%"
                            y: "15%"
                            stroke: 'black'
                            #onClick: => @props.change_gig(@props.cursor)
                            onClick: => @props.focus_cell_selection(@props.section, @props.cursor)
                            style:
                                cursor: 'pointer'
                            ,
                            @props.cursor
        else
            svg
                width: '100%'
                height: '100%'



module.exports = -> arrow