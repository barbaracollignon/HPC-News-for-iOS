//
//  HPCNewsFinder.m
//  HPC News
//
//  Created by Barbara Collignon on 10/10/11.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import "HPCNewsFinder.h"
#import "JSON.h" // The file is in the Json directory

@interface NSString (parsing) 

-(NSString*) replace_em ;
-(NSString*) find_link1 ;
-(NSString*) removeLink;
-(NSString*) removeLink2;
-(NSString*) removeLink3;
-(NSString*) removejustin;
-(NSString*) removeBS;
-(NSString*) LinkInside;

@end 

@implementation HPCNewsFinder 

@synthesize delegate,myarray;

-(void)getHPCNews{
    nbtweet=0;
    besthpcnews=[[NSMutableArray alloc] init];
    [myarray=[NSMutableArray alloc] init ];
 //   myarray=[[NSMutableArray alloc] init];
    isHPCnews=YES;
    TwitterConnection *connection= [[TwitterConnection alloc] init];
    connection.delegate=self;
 
 
   [connection performSearch:@"insideHPC"];
  
    [connection release];

}

-(void)twitterConnection:(TwitterConnection *)connection didReceiveData:(NSData *)data{
 
  // XML PARSING FOR TW API 1.0
  //  NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
  //  parser.delegate=self;
  //  [parser parse];
  //  [parser release];
  //  parser=nil;
    
    // JSON PARSING FOR TW API 1.1
    if (data != nil)
   	{
        NSString *jsonString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		
		// Create a dictionary from the JSON string
        if([jsonString JSONValue] != nil)
		{
           // NSDictionary *results = [jsonString JSONValue];
		            
        }
                                     
    }
    
    
      
}

-(void)parser:(NSXMLParser*) parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    if([elementName isEqualToString:@"entry"]){
        currentnews= [[bestnews alloc] init];
        isHPCnews=YES;
    } else if ([elementName isEqualToString:@"content"]){
      //   currentstring=[[NSMutableString alloc] initWithCapacity:20];
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
           
            NSString *pretmp=[currentstring replace_em];
            NSString *tmp=[pretmp removeLink3];
            NSString *tmp2=[tmp removeLink];
            
            currentnews.tweet=[tmp2 removejustin];
                    if(currentnews.tweet==nil){
                isHPCnews=NO;
                
            }
       
          if (currentnews.tweet !=nil) {
                
            
            currentnews.tweetlink=[tmp LinkInside];
                
                if (currentnews.tweetlink == nil) {
                    
                //    NSLog(@"%@",currentnews.tweet);
                    
                }
              
            }
            
           currentnews.tweet = [currentnews.tweet stringByAppendingString:@"via @insideHPC"];  
        //   NSLog(@"INSIDEHPC: %@",currentnews.tweet);
            
            if (currentnews.tweetlink != nil) {
                
                [tweetlink_global addObject:currentnews.tweetlink];
                
                nbtweet++;

             }
    
        } else if ([elementName isEqualToString:@"published"]) {
            currentnews.createdAt = currentstring2;
            
        } else if ([elementName isEqualToString:@"feed"]) {
            
            [delegate hpcnewsFinder:self didFindHPCNews:[besthpcnews autorelease]];
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
    
  //  NSLog(@"Processing Value: %@", currentstring);
}


@end


@implementation NSString (parsing)

-(NSString*) removejustin{
    
    int index = [self rangeOfString:@"Just in:"].location;
    //  int index2 = [self rangeOfString:@"\">"].location;
    NSString *substring = nil;
    //  NSString *mylink = nil;
    
    if (index < self.length){
       
        substring=[self substringFromIndex:index+8];
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

-(NSString*) replace_em {
    
    NSString* myString = [[[NSString alloc] init] autorelease];
   // [myString initWithString:self] ;
    
    NSArray* foo = [self componentsSeparatedByString:@"<em>"] ;
    NSString* word = nil ;
   // NSString *test = nil ;
    
    for (word in foo) {
 
        myString =  [myString stringByAppendingString:word] ;
           
    }
    
    return myString;
    
}

-(NSString*) find_link1 {
    
       
    NSArray* foo = [self componentsSeparatedByString:@" "] ;
    
      
    int i = [foo count] ;
    int j = i-1 ;
    
    
    return [foo objectAtIndex:j];
    
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

-(NSString*) removeBS {
    
    
    int index = [self rangeOfString:@"http"].location;
    
    
    NSString *substring = nil;
    
    substring=[self substringWithRange:NSMakeRange(0,index)];
    
    return substring;
}

-(NSString*) removeLink2 {
    
    int index = [self rangeOfString:@"<a class="].location;
    int index2 = [self rangeOfString:@"/a>"].location;
    
    NSString *substring = nil;
    
    if (index < self.length){
        substring=[self substringFromIndex:index2+4]; 
    } else {
     //   substring=[self substringFromIndex:index2];    
    }
    
    return substring;
    
}


-(NSString*) LinkInside {
    
    NSString *mylink=nil;
    NSRange start = [self rangeOfString:@"<a href=\""];
 //   NSRange end = [self rangeOfString:@"\">"];
    NSRange end = [self rangeOfString:@"\" class"];
    
    if (start.location < self.length) {
       
    mylink= [self substringWithRange:NSMakeRange(start.location+9, end.location-start.location-9)];
        
    }
    
    return mylink;
      
    //  return nil;
}

@end
