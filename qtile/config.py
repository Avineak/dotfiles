from libqtile import bar, hook, layout, widget, configurable
from libqtile.command import lazy
from libqtile.config import Click, Drag, Group, Key, Screen, Match
import os, subprocess
# from libqtile.confreader import Config
# from libqtile.core.xcore import XCore

# Config.from_file(XCore(), os.path.expanduser("~/.config/qtile/config.py"))



wmname = 'qtile'
mod = 'mod4'

def spawnner(qtile):
    qtile.lazy.spawn('firefox')
# Key bindings
keys = [
    # Window manager controls
    Key([mod, 'shift'], 'r', lazy.restart()),
    Key([mod, 'control'], 'q', lazy.shutdown()),
    Key([mod], 'r', lazy.spawn("rofi -modi drun -show drun")),
    Key([mod], 'Return', lazy.spawn('kitty')),
    Key([mod, 'shift'], 'q',      lazy.window.kill()),

    Key([mod], 'Tab', lazy.layout.next()),
    Key([mod], 'Left', lazy.screen.prevgroup()),
    Key([mod], 'Right', lazy.screen.nextgroup()),

    # Layout modification
    Key([mod, 'control'], 'space', lazy.window.toggle_floating()),

    # Switch between windows in current stack pane
    Key([mod], 'k', lazy.layout.down()),
    Key([mod], 'j', lazy.layout.up()),

    # Move windows up or down in current stack
    Key([mod, 'control'], 'k', lazy.layout.shuffle_down()),
    Key([mod, 'control'], 'j', lazy.layout.shuffle_up()),

    # Switch window focus to other pane(s) of stack
    Key([mod], 'space', lazy.next_layout()),

    # Toggle between different layouts as defined below
    # Key([mod], 'Tab',    lazy.next_layout()),

    #Application shortcuts
    Key([mod], 'F1', lazy.spawn('kitty')),
    Key([mod], 'F2', lazy.spawn('firefox')),
    Key([mod], 'F3', lazy.spawn('thunar')),
    Key([mod], 'F5', lazy.spawn('pamac-manager')),

    #Changing Layout
    Key([mod], 'f', lazy.window.toggle_fullscreen()),
    Key([mod], 't', lazy.window.toggle_floating()),

    # Switching toggle
    Key([mod], 'Escape', lazy.screen.toggle_group()),

    # Brightness
    # Key(XF86MonBrightnessUp, lazy.spawn(os.execute("xbacklight -inc 10")));
    # Key(XF86MonBrightnessDown, os.execute("xbacklight -dec 10")),

    #locking and other
    Key([mod, 'shift'],'l', lazy.spawn('xlock')),
    Key([mod, 'shift'],'p', lazy.function(spawnner)),

]
floating_layout = layout.Floating(float_rules=[
    {
        'wmclass': 'Matplotlib'
    },
    {
        'wmclass': 'cataclysm-tiles'
    },
    {
        'wmclass': 'file_progress'
    },
    {
        'wmclass': 'notification'
    },
    {
        'wmclass': 'toolbar'
    },
    {
        'wmclass': 'splash'
    },
    {
        'wmclass': 'dialog'
    },
    {
        'wmclass': 'pinentry'
    },
    {
        'wmclass': 'pinentry-gtk-2'
    },
    {
        'wname': 'Execute File'
    },
    {
        'wname': 'Open'
    },
    {
        'wname': 'Confirm File Replacing'
    },
    {
        'role': 'about'
    },
])

# Mouse bindings and options
mouse = (
    Drag([mod], 'Button1', lazy.window.set_position_floating(),
        start=lazy.window.get_position()),
    Drag([mod], 'Button3', lazy.window.set_size_floating(),
        start=lazy.window.get_size()),
)

bring_front_click = True
cursor_warp = False
follow_mouse_focus = True
focus_on_window_activation = 'focus'

# Groups
groups = [
    Group('1', matches=[Match(wm_class=['kitty'])]),
    Group('2', matches=[Match(wm_class=['firefox'])]),
    Group('3', matches=[Match(wm_class=['Thunar'])]),
    Group('4', matches=[Match(wm_class=['xterm'])]),
    Group('5', matches=[Match(wm_class=['Pamac-manager'])]),
]
groups[0].label = ""
groups[1].label = ""
groups[2].label = ""
groups[3].label = ""
groups[4].label = ""
for i in groups:
    # mod + letter of group = switch to group
    keys.append(Key([mod], i.name, lazy.group[i.name].toscreen()))

    # mod + shift + letter of group = switch to & move focused window to group
    keys.append(Key([mod, 'shift'], i.name, lazy.window.togroup(i.name)))

dgroups_key_binder = None
dgroups_app_rules = []

# Layouts
layouts = [
    layout.Max(),
    layout.Stack(num_stacks=2),
    layout.Tile(),
    layout.RatioTile(),
    layout.Matrix(),
    layout.MonadTall()
]

floating_layout = layout.Floating()

# Screens and widget options
screens = [
    Screen(
        top=bar.Bar(
            widgets=[
                widget.GroupBox(
                    highlight_method='block',
                    inactive='999999'
                ),
                widget.Spacer(),
                widget.Prompt(),
                widget.CPU(),
                widget.Sep(),
                widget.Memory(),
                widget.Sep(),
                widget.Clock(format='%a %d %b %I:%M %p'),
            ],
            size=25,
            background=['222222', '111111'],
        ),
        bottom=bar.Bar(
            widgets=[
                # widget.WindowName(),
                # widget.CurrentLayoutIcon(),
                widget.TaskList(),
                widget.Systray()
            ],
            size=25,
            background=['222222', '111111'],
        ),
    ),
]

widget_defaults = dict(
    font='Arial',
    fontsize=12,
)

auto_fullscreen = True


def main(qtile):
    ''' This function is called when Qtile starts. '''
    pass

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([home])
