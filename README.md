# StumpWM Nuclear

Nuclear music player module for StumpWM

## Requirements

- [Nuclear](https://github.com/nukeop/nuclear) music player installed
- [Dexador](https://github.com/fukamachi/dexador) library installed
- [CL-JSON](https://github.com/hankhero/cl-json) library installed

## Installation

- Enable HTTP API in the Nuclear player settings

```bash
cd ~/.stumpwm.d/modules/
git clone https://github.com/Junker/stumpwm-nuclear nuclear
```

install dependency libraries:

```lisp
(ql:quickload "dexador")
(ql:quickload "cl-json")
```

load module:

```lisp
(stumpwm:add-to-load-path "~/.stumpwm.d/modules/nuclear")
(load-module "nuclear")
```

## Usage

```lisp
  (define-key *top-map* (kbd "XF86AudioPlay") "nuclear-play-pause")
  (define-key *top-map* (kbd "XF86AudioPrev") "nuclear-previous")
  (define-key *top-map* (kbd "XF86AudioNext") "nuclear-next")
  (define-key *top-map* (kbd "XF86AudioStop") "nuclear-stop")

```

### Additional commands

- nuclear-play
- nuclear-mute
- nuclear-quit

### Parameters

- nuclear:\*url\* - API URL of Nuclear player (default: "http://localhost:3100")

### Modeline

%N - nuclear formatter

#### Parameters for modeline

- nuclear:\*modeline-fmt\* - format of nuclear modeline (default: "%a: %n")
  - %a: artist
  - %n: name
  - %d: duration
  - %p: progress
  - %l: stream-loading
  - %s: status
