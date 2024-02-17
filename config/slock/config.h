/* user and group to drop privileges to */
static const char *user  = "woland";
static const char *group = "woland";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "black",     /* after initialization */
	[INPUT] =  "#005577",   /* during input */
	[FAILED] = "#CC3333",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

/* Background image path, should be available to the user above */
static const char* background_image = "/home/woland/Pictures/Dracula-Wallpapers/wallpaper-master/arch.png";
