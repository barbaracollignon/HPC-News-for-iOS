//
//  HPCNewsFinder.m
//  HPC News
//
//  Created by Barbara Collignon on 10/10/11.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import "HPCNewsFinderFeedWire.h"
#import "JSON.h" // JSON FILES are in the JSON directory

@interface NSString (parsing) 

//Painful parsing
-(NSString*) removeLink;
-(NSString*) removeLink2;
-(NSString*) removeLink3;
-(NSString*) removejustin;
-(NSString*) replace_em;
-(NSString*) replace_em2;
-(NSString*) removeBS;
-(NSString*) find_link2;
-(NSString*) replace:(NSString*) hashtag;
-(NSString*) LinkSCO;

@end

@implementation HPCNewsFinderFeedWire 

@synthesize delegate,myarray;

-(void)getHPCNews{
    
    nbtweet=0;
    besthpcnews=[[NSMutableArray alloc] init];
    [myarray=[NSMutableArray alloc] init ];

    isHPCnews=YES;
    TwitterConnection *connection= [[TwitterConnection alloc] init];
    connection.delegate=self;   
  
    [connection performSearch:@"SC_Online"];
    
    [connection release];

}

-(void)twitterConnection:(TwitterConnection *)connection didReceiveData:(NSData *)data{
 
 //   Disgusting XML Parsing
 //   NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
 //   parser.delegate=self;
 //   [parser parse];
 //   [parser release];
 //   parser=nil;
  
    
   // For Json parsing
    if (data != nil)
	{
        NSString *jsonString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		
        NSLog(@"%@",jsonString);
        
		// Create a dictionary from the JSON string
        if([jsonString JSONValue] != nil)
		{
            
            
            NSDictionary *results = [jsonString JSONValue];
            
        }
        
    }

    
}

-(void)parser:(NSXMLParser*) parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    if([elementName isEqualToString:@"entry"]){
        currentnews= [[bestnews alloc] init];
        isHPCnews=YES;
    } else if ([elementName isEqualToString:@"content"]){
        currentstring=[[NSMutableString alloc] init];
    } else if ([elementName isEqualToString:@"published"]) {
        currentstring2=[[NSMutableString alloc] init];   
    }
    
}

-(void)parser:(NSXMLParser*) parser didEndElement:(NSString*)elementName namespaceURI:(NSString*) namespaceURI qualifiedName:(NSString*)qName

{
        if ([elementName isEqualToString:@"entry"]) {
            if(isHPCnews)
                [besthpcnews addObject:currentnews];
            [currentnews release];
            currentnews=nil;
            
        } else if([elementName isEqualToString:@"content"]){
           
            NSString *tmp=[currentstring replace_em];
            NSString *tmpP=[tmp replace_em2];
            
            NSString *tmp2=[tmpP removeLink3];
            currentnews.tweet = [tmp2 removeLink];
            
            currentnews.tweetlink=[currentstring LinkSCO];
          
            if (currentnews.tweet == nil) {
                currentnews.tweetlink = [tmpP find_link2];
                currentnews.tweet = tmpP;
            }
            
             currentnews.tweet = [currentnews.tweet stringByAppendingString:@"via @SC_Online"];
            
        
            if(currentnews.tweet==nil || [currentnews.tweet isEqualToString:@""] == TRUE){
                isHPCnews=NO;
                currentnews.tweetlink=nil;
            }
            
            if(currentnews.tweetlink==nil){
                isHPCnews=NO;
                currentnews.tweet=nil;
            }

            if (isHPCnews) {
                 nbtweet++;
                
                [tweetlink_global addObject:currentnews.tweetlink];
             
            }
             
                   
            
        } else if ([elementName isEqualToString:@"published"]) {
            currentnews.createdAt = currentstring2;
        
            
        } else if ([elementName isEqualToString:@"feed"]) {
            
            [delegate hpcnewsFinderFeedWire:self didFindHPCNews:[besthpcnews autorelease]];
            [myarray autorelease];
           
            
        }
        
    
        [currentstring release];
        currentstring = nil;
        [currentstring2 release];
        currentstring2 = nil;
    
}


-(void)parser:(NSXMLParser*)parser foundCharacters:(NSString*)string {
    if (currentstring!=nil) {
        [currentstring appendString:string];
        //  [currentstring release];
        //  currentstring = nil;
    } else {
        currentstring = [[NSMutableString alloc] initWithString:string];
    }
    
    if (currentstring2!=nil) {
        [currentstring2 appendString:string];
        //  [currentstring release];
        //  currentstring = nil;
    } else {
        currentstring2 = [[NSMutableString alloc] initWithString:string];
    }
    
  
}

@end

@implementation NSString (parsing)


-(NSString*) replace_em {
    
    NSString* myString = [[[NSString alloc] init] autorelease];
    
    NSArray* foo = [self componentsSeparatedByString:@"<em>"] ;
    NSString* word = nil ;
    
    for (word in foo) {
        
        myString =  [myString stringByAppendingString:word] ;
       
    }
    
    return myString;
    
}


-(NSString*) find_link2 {
     
    NSArray* foo = [self componentsSeparatedByString:@" "];
        
    int i = [foo count] ;
    int j = i-1 ;
      
    return [foo objectAtIndex:j];
    
}


-(NSString*) replace_em2 {
    
    NSString* myString = [[[NSString alloc] init] autorelease];
    
    NSArray* foo = [self componentsSeparatedByString:@"</em>"] ;
    NSString* word = nil ;
    
    for (word in foo) {
        
        myString =  [myString stringByAppendingString:word] ;
              
        
    }
    
    return myString;
    
}

-(NSString*) removeBS {
    
    
    int index = [self rangeOfString:@"http"].location;
    
    
    NSString *substring = nil;
    
    substring=[self substringWithRange:NSMakeRange(0,index)];
    
    return substring;
}

-(NSString*) removejustin{
    
    int index = [self rangeOfString:@"Just in:"].location;
   
    NSString *substring = nil;
    
    if (index < self.length){
       
        substring=[self substringFromIndex:index+8];
    }

    return substring;
}

-(NSString*) replace:(NSString*) hashtag {
    
    NSString* myString =  @"<a href=\"http://search.twitter.com/search?q=%23wordtoreplace\" title=\"#wordtoreplace\" class=\" \">#wordtoreplace</a>" ;
        
    
    
    NSRange rOriginal = [myString rangeOfString:@"wordtoreplace"];
    if (NSNotFound != rOriginal.location) {
        myString = [myString
                    stringByReplacingCharactersInRange:rOriginal
                    withString:hashtag];
        
     //   NSLog(@"MYSTRING:%@",myString);
        
    }
    
    rOriginal = [myString rangeOfString:@"wordtoreplace"];
    if (NSNotFound != rOriginal.location) {
        myString = [myString
                    stringByReplacingCharactersInRange:rOriginal
                    withString:hashtag];
        
    //    NSLog(@"MYSTRING:%@",myString);
        
    }

    rOriginal = [myString rangeOfString:@"wordtoreplace"];
    if (NSNotFound != rOriginal.location) {
        myString = [myString
                    stringByReplacingCharactersInRange:rOriginal
                    withString:hashtag];
        
    //    NSLog(@"MYSTRING:%@",myString);
        
    }

    
    
    NSArray *words = [self componentsSeparatedByString:myString];
    
    NSMutableString *substring = [[[NSMutableString alloc] init ] autorelease] ;
    
    int j = 0 ; 
    
    for (NSString *word in words){
        
        j++;
        
        [substring appendString:word];    
        
        if (j == 1) {
            
            [substring appendString:hashtag];
            
        }
        
    }    
    
    return substring;

    
}

-(NSString*) removeLink{
    
 
     int index = [self rangeOfString:@"<a href=\""].location;
  
     NSString *substring = nil;
      
     if (index < self.length){
     substring=[self substringWithRange:NSMakeRange(0, index)];
 
     }
     return substring;
    
}

-(NSString*) removeLink3 {
    
    
    int index = [self rangeOfString:@"<a class="].location;
    int index2 = [self rangeOfString:@"/a>"].location;
    
    NSString *substring = nil;
    
    if (index > self.length && index2 < self.length){
        
        substring=[self substringWithRange:NSMakeRange(0,index2)];
        
    } else {
          
    }
    
    return substring;
}


-(NSString*) removeLink2 {
    
    
    int index = [self rangeOfString:@"<a class="].location;
    int index2 = [self rangeOfString:@"/a>"].location;
    
    NSString *substring = nil;
    
    if (index < self.length){
     
        substring=[self substringFromIndex:index2+4]; 
    } else {
      
    }
    
    return substring;

}

-(NSString*) LinkSCO {
    
    NSString *mylink=nil;
    NSRange start = [self rangeOfString:@"<a href=\""];
    NSRange end = [self rangeOfString:@"\" class"];
    
   
    if (start.location < self.length) {
        mylink= [self substringWithRange:NSMakeRange(start.location+9, end.location-start.location-9)];
             
        }
    
    return mylink;

}

@end
