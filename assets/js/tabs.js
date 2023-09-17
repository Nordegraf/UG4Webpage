document.querySelectorAll('button[data-bs-toggle="tab"]').forEach((t,i)=>{
    t.addEventListener('show.bs.tab', function (e) {
        let targetClass = t.dataset.bsTarget

        // panes to be shown
        var hiddenPanes = document.querySelectorAll('.tab-pane' + targetClass)
        // currently shown panes
        var activePanes = document.querySelectorAll('.tab-pane.active')

        // hide currently shown panes
        activePanes.forEach((pane, i) => {
            pane.classList.remove('show')
            pane.classList.remove('active')
        })

        // show panes to be shown
        hiddenPanes.forEach((pane, i) => {
            pane.classList.add('show')
            pane.classList.add('active')
        })

        // switch $HOME and %HOMEPATH% in homepath divs
        var homepathDivs = document.querySelectorAll('.homepath')
        homepathDivs.forEach((div, i) => {
            if (div.innerHTML == '$HOME') {
                div.innerHTML = '%HOMEPATH%'
            } else {
                div.innerHTML = '$HOME'
            }
        })
    })
})