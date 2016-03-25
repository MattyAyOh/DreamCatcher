//
//  DBConnection.h
//
//  Copyright 2013 UltimateApp wrold. All rights reserved.
//

#import <Foundation/Foundation.h>
// This includes the header for the SQLite library.
#import <sqlite3.h>

@interface DBConnection : NSObject 
{
	//reference to the SQLite database.
@private
	sqlite3 *g_database;
}

@property (nonatomic,assign,readonly) sqlite3 *database;

+ (DBConnection *) sharedConnection;

+ (BOOL) executeQuery:(NSString *)query;

+ (NSMutableArray *) fetchResults:(NSString *)query;

+ (int) rowCountForTable:(NSString *)table where:(NSString *)where;

+ (void) errorMessage:(NSString *)msg;

+ (void) closeConnection;

// Init database
- (id)initConnection;

- (void)close;

@end
