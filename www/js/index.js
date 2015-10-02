var app = {

    initialize: function() {
        this.bindEvents();
    },

    bindEvents: function() {
        $(".discovery_button").on('touchstart', this.discover);
    },

    login: function() {
        $("h1").text("Loading...");
        var d = $("#login_form").serialize();
        $.ajax({
            success: function(response) {
                if (!response['verified']) {
                    $("h1").text("Invalid credentials");
                } else {
                    this.verifyLoggedIn()

                }
                return false;
            }.bind(this),
            error: function(response) {
                $("h1").text("Error");
                return false;
            },
            url: "http://tabdextension.com/login",
            method: "POST",
            data: d
        });
    },

    verifyLoggedIn: function() {
        $.ajax({
            success: function(response) {
                if (response.verified) {
                    $(".login_container").hide();
                    if (response.verified) {
                        this.username = response.username;
                        $("h1").text("Tab History");
                        $(".app").removeClass("app");
                        $(".login_container").hide();
                        $(".history_container").show();
                    }
                    this.getTabHistory()
                } else {
                    $("h1").text("Invalid credentials when verifying");
                }
            }.bind(this),
            error: function(response) {
                $(".login_container").hide();
                return false;
            },
            url: "http://tabdextension.com/logged_in",
            method: "GET"
        });
    },

    abbreviateName: function(name, letters) {
        if (name.length > letters) {
            return name.substring(0, letters - 3) + "..."
        } else {
            return name;
        }
    },

    getTabHistory: function(ev) {
        $.ajax({
            url: "http://tabdextension.com/tab_history",
            method: "GET",
            error: function(response) {
                alert("error");
            },
            success: function(response) {
                response.tabs.forEach(function(tab) {
                    var tmpl = this.historyTempl(tab);
                    $("ul").append(tmpl);
                }.bind(this));
            }.bind(this)
        })
    },

    historyTempl: function(tab) {
        var sentTab = tab.from_user === this.username || (tab.from_user === null && tab.to_user !== this.username);
        var shortUrl = this.abbreviateName(tab.url.replace("https://", "").replace("http://", "").replace("www.", ""), 20);
        var icon = sentTab ? "right" : "left";
        return "<li><i class=\"fa fa-arrow-" + icon + "\"></i><a href=\"" + tab.url + "\">" + shortUrl + "</a></li>";
    },

    discover: function() {
        navigator.notification.vibrate(40);
        try {
            new Toast().showShortCenter("yay");
            $("h1").text("clicked");
        } catch(err) {
            $("h1").text(err.message);
        }
    }
};
