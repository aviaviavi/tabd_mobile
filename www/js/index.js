/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
var app = {
    // Application Constructor

    initialize: function() {
        this.bindEvents();
    },
    // Bind Event Listeners
    //
    // Bind any events that are required on startup. Common events are:
    // 'load', 'deviceready', 'offline', and 'online'.
    bindEvents: function() {
        document.addEventListener('deviceready', this.onDeviceReady, false);
    },
    // deviceready Event Handler
    //
    // The scope of 'this' is the event. In order to call the 'receivedEvent'
    // function, we must explicitly call 'app.receivedEvent(...);'
    onDeviceReady: function() {
        app.receivedEvent('deviceready');
    },
    // Update DOM on a Received Event
    receivedEvent: function(id) {
        // var parentElement = document.getElementById(id);
        // var listeningElement = parentElement.querySelector('.listening');
        // var receivedElement = parentElement.querySelector('.received');

        // listeningElement.setAttribute('style', 'display:none;');
        // receivedElement.setAttribute('style', 'display:block;');

        // console.log('Received Event: ' + id);
    },

    login: function() {
        var d = $("#login_form").serialize();
        $.ajax({
            success: function(response) {
                if (!response['verified']) {
                    $("h1").text("login fail");
                } else {
                    $("h1").text("Tab History");
                    $(".app").removeClass("app");
                    this.username = $(".login-username").val();
                    this.getTabHistory();
                }
                $(".login_container").hide();
                return false;
            }.bind(this),
            error: function(response) {
                $("h1").text(JSON.stringify(response));
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
                    this.getTabHistory()
                } else {
                    $(".login_container").hide();
                }
                return false;
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
        var shortUrl = this.abbreviateName(tab.url.replace("http://", "").replace("http://", "").replace("www.", ""), 20);
        var icon = sentTab ? "right" : "left";
        return "<li><i class=\"fa fa-arrow-" + icon + "\"></i><a href=\"" + tab.url + "\">" + shortUrl + "</a></li>";
    }
};
