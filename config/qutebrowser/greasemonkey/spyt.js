// ==UserScript==
// @name        Video Intro Skipper
// @author      SkauOfArcadia
// @match       *://m.youtube.com/*
// @match       *://youtu.be/*
// @match       *://www.youtube.com/*
// @match       *://www.youtube-nocookie.com/embed/*
// @match       *://inv.riverside.rocks/*
// @match       *://invidio.xamh.de/*
// @match       *://invidious.esmailelbob.xyz/*
// @match       *://invidious.flokinet.to/*
// @match       *://invidious-jp.kavin.rocks/*
// @match       *://invidious-us.kavin.rocks/*
// @match       *://invidious.kavin.rocks/*
// @match       *://invidious.lunar.icu/*
// @match       *://inv.bp.mutahar.rocks/*
// @match       *://invidious.mutahar.rocks/*
// @match       *://invidious.namazso.eu/*
// @match       *://invidious.osi.kr/*
// @match       *://invidious.privacy.gd/*
// @match       *://invidious.snopyta.org/*
// @match       *://invidious.weblibre.org/*
// @match       *://tube.cthd.icu/*
// @match       *://vid.mint.lgbt/*
// @match       *://vid.puffyan.us/*
// @match       *://yewtu.be/*
// @match       *://youtube.076.ne.jp/*
// @match       *://yt.artemislena.eu/*
// @match       *://il.ax/*
// @match       *://piped.kavin.rocks/*
// @match       *://piped.mint.lgbt/*
// @match       *://piped.moomoo.me/*
// @match       *://piped.notyourcomputer.net/*
// @match       *://piped.privacy.com.de/*
// @match       *://piped.silkky.cloud/*
// @match       *://piped.syncpundit.com/*
// @match       *://piped.tokhmi.xyz/*
// @run-at      document-start
// @grant       GM.xmlHttpRequest
// @require     https://greasemonkey.github.io/gm4-polyfill/gm4-polyfill.js
// @version     1.2.2
// @license     GPL-3.0-or-later; https://www.gnu.org/licenses/gpl-3.0.txt
// @description Skips annoying intros, sponsors and w/e at the start of videos on YouTube and its frontends like Invidious and Piped using the SponsorBlock API.
// @namespace https://greasyfork.org/users/751327
// ==/UserScript==
/**
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
function go(){
    let params = new URLSearchParams(location.search);
    if(!params.has('t') && !params.has('start') && (params.has('v') || location.pathname.indexOf('/embed/') === 0 || location.pathname.indexOf('/v/') === 0)) {
        let videoId;
        let startAt = 0;
        if(params.has('v')) {
            videoId = params.get('v');
        } else {
            videoId = location.pathname.replace('/v/','').replace('/embed/','');
        }
    
        GM.xmlHttpRequest({
            method: "GET",
            url: 'https://sponsor.ajay.app/api/skipSegments?category=sponsor&category=selfpromo&category=interaction&category=intro&category=preview&category=music_offtopic&videoID=' + videoId,
            headers: {
                'Accept': 'application/json'
            },
            onload: function(response) {
                const result = JSON.parse(response.responseText);

                for(var k in result) {
                    if (Math.floor(result[k].segment[0]) <= Math.ceil(startAt)){
                        startAt = result[k].segment[1];
                    }
                }

                if(startAt > 0){
                    params.set('start', Math.round(startAt));
                    location.replace(location.protocol + '//' + location.hostname + location.pathname + '?' + params + location.hash);
                }
            }
          });
    }
}

go();
var oldHref = document.location.href;

window.addEventListener("load", function() {
    let observer = new MutationObserver(function(mutations) {
        mutations.forEach(function(mutation) {
            if (oldHref != document.location.href) {
                oldHref = document.location.href;
                go();
            }
        });
    });

    let config = {
        childList: true,
        subtree: true
    };

    observer.observe(document.body, config);
});
