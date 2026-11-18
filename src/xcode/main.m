#import <Cocoa/Cocoa.h>
#import "SDL2/SDL.h"
#import "Launcher.h"

@interface SDLApplication : NSApplication
@end

@implementation SDLApplication
@end

#ifdef main
#  undef main
#endif

int main(int argc, char *argv[])
{
    BOOL direct = NO;
    int i;
    for(i = 0; i < argc; i++)
    {
        if(strcmp(argv[i], "-d") == 0 || strcmp(argv[i], "-nolauncher") == 0) { direct = YES; break; }
    }
    if(!direct && ![[NSBundle mainBundle] pathForResource:@"MainMenu" ofType:@"nib"]) direct = YES;
    if(direct)
    {
        char **args = (char **)malloc(sizeof(char *) * (argc + 1));
        int nargc = 0;
        for(i = 0; i < argc; i++) if(strcmp(argv[i], "-nolauncher") != 0) args[nargc++] = argv[i];
        args[nargc] = NULL;
        int ret = SDL_main(nargc, args);
        free(args);
        return ret;
    }
    
	// neither of the followin is necessary as the principal class is set to SDLApplication in the plist 
	//[SDLApplication sharedApplication];
    //[SDLApplication poseAsClass:[NSApplication class]];
	
    return NSApplicationMain(argc,  (const char **)argv);
}
