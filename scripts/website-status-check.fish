#!/bin/fish

# This script is used on my server to monitor the status of my websites.
#
# `sendmail` is provided by postfix.
#
# Fish script because it's easier to work with.

function mail
    set mail "\
From: Status <status@icelk.dev>
Subject: Website down

Website $argv[1] is $argv[2]."

    echo $mail | sendmail main@icelk.dev
end

function e
    string join \n $page
end

set page (curl -L icelk.dev)

if test $status -ne 0
    mail icelk.dev down
end

e | rg -Uq '<div class="item">
                <a href="/">Home</a>
            </div>'

if test $status -ne 0
    mail icelk.dev "having problems"
end

e | rg -Uq '<div class="head">
        <img id="main-icon" src="icelk-icon.png" alt="icelk logo" />
        <h1 class="head-title">Programming, Ice Cold and Digested.</h1>
    </div>'

if test $status -ne 0
    mail icelk.dev "having problems"
end

set page (curl -L kvarn.org)

if test $status -ne 0
    mail kvarn.org down
end

e | rg -q '<b>A forward-thinking fast web server designed to fit <i>your</i> needs, efficiently.</b>'

if test $status -ne 0
    mail kvarn.org "having problems"
end

set page (curl -I https://agde.dev)

if test $status -ne 0
    mail agde.dev down
end

e | rg -q 'location: https://github.com/Icelk/agde/'                                                                                                                                                                                                        
                                                                                                                                                                                                                                                            
if test $status -ne 0                                                                                                                                                                                                                                       
    mail agde.dev "having issues with redirect"                                                                                                                                                                                                             
end 
