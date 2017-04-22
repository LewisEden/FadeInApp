if (toggleNav == 0) {
    document.getElementById("sidenav").style.width = "223px";
    document.body.style.overflowY = "hidden"
    if (document.documentElement.clientWidth > 768) {
      document.getElementById("actionbar").style.marginLeft = "223px";
    } else {
      document.getElementById("overlay").style.width = "100%";
    }
  }