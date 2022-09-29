#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>

#define FRAME_WIDTH		640
#define FRAME_HEIGHT	480

#define FRAME_BUFFER_DEVICE	"/dev/fb0"
extern ID() ;
extern NAME() ;
extern int drawJuliaSet( int cX, int cY, int16_t (*frame)[640] );

int main()
{
	//RGB16
	int16_t frame[FRAME_HEIGHT][FRAME_WIDTH];

	int max_cX = -700;
	int min_cY = 270;

	int cY_step = -5;
	int cX = -700;	// x = -700~-700
	int cY;			// y = 400~270

	int fd;

	printf( "Function1: Name\n" );

	//Dummy Function. Please refer to the specification of Project 1.

	NAME();
	extern name, name2, name3 ;

	printf( "Function2: ID\n" );

	//Dummy Function. Please refer to the specification of Project 1.

    ID() ;
    extern id1, id2, id3, ans ;

	//Dummy printout. Please refer to the specification of Project 1.
	printf( "Main Function:\n" );
	printf( "*****Print All*****\n" );
	printf( "Team 02\n" );
	printf( "%d	 %s\n ", id1, &name ) ;
	printf( "%d	 %s\n ", id2, &name2 ) ;
	printf( "%d	 %s\n ", id3, &name3 ) ;

	printf( "ID Summation = %d\n", ans ) ;

	printf( "*****End Print*****\n" );
	printf( "\n***** Please enter p to draw Julia Set animation *****\n" );

	while(getchar()!='p') {}

	system( "clear" );

	fd = open( FRAME_BUFFER_DEVICE, (O_RDWR | O_SYNC) );

	if( fd<0 )
	{	printf( "Frame Buffer Device Open Error!!\n" );	}
	else
	{
		for( cY=400 ; cY>=270; cY = cY - 5 ) {       // for( cY=400 ; cY>=min_cY; cY = cY + cY_step )

			drawJuliaSet( cX, cY, frame );

			write( fd, frame, sizeof(int16_t)*FRAME_HEIGHT*FRAME_WIDTH );

			lseek( fd, 0, SEEK_SET );
		}

		//Dummy printout. Please refer to the specification of Project 1.

		printf( ".*.*.*.<:: Happy New Year ::>.*.*.*.\n" );
		printf( "by Team 02\n" );

		printf( "%d	%s\n ", id1, &name ) ;
		printf( "%d	%s\n ", id2, &name2 ) ;
		printf( "%d	%s\n ", id3, &name3 ) ;

		close( fd );
	}

	while(getchar()!='p') {}
   	return 0;
}

