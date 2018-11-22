# WAYLAND_PROTOCOLS=/usr/share/wayland-protocols

# # wayland-scanner is a tool which generates C headers and rigging for Wayland
# # protocols, which are specified in XML. wlroots requires you to rig these up
# # to your build system yourself and provide them in the include path.
# xdg-shell-protocol.h:
# 	wayland-scanner server-header \
# 		$(WAYLAND_PROTOCOLS)/stable/xdg-shell/xdg-shell.xml $@

# xdg-shell-protocol.c: xdg-shell-protocol.h
# 	wayland-scanner private-code \
# 		$(WAYLAND_PROTOCOLS)/stable/xdg-shell/xdg-shell.xml $@

debug: cage.c
	$(CC) $(CFLAGS) -g -Werror -Wall -I. -DWLR_USE_UNSTABLE -DDEBUG \
		$(shell pkg-config --cflags --libs wlroots) \
		$(shell pkg-config --cflags --libs wayland-server) \
		$(shell pkg-config --cflags --libs xkbcommon) \
		-o cage $<

release: cage.c
	$(CC) $(CFLAGS) -Werror -Wall -I. -DWLR_USE_UNSTABLE \
		$(shell pkg-config --cflags --libs wlroots) \
		$(shell pkg-config --cflags --libs wayland-server) \
		$(shell pkg-config --cflags --libs xkbcommon) \
		-o cage $<

clean:
	rm -f cage

.DEFAULT_GOAL=debug
.PHONY: debug release clean
