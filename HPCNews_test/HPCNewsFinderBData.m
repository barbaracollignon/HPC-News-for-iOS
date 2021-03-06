//
//  HPCNewsFinderBData.m
//  HPC News
//
//  Created by Barbara Collignon on 9/4/12.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import "HPCNewsFinderBData.h"
#import "JSON.h" //The file is in the Json directory

@interface NSString (parsing)

//Painful parsing
-(NSString*) removeLink;
-(NSString*) removeLink2;
-(NSString*) replace_em;
-(NSString*) find_link7;
-(NSString*) removeLink3;
-(NSString*) removejustin;
-(NSString*) removeRT;
-(NSString*) removeCLASS;
-(NSString*) LinkBD;

-(NSString*) replace:(NSString*) hashtag ;
-(NSString*) replaceAT:(NSString*) hashtag ;

@end

@implementation HPCNewsFinderBData

@synthesize delegate,myarray;

-(void)getHPCNews{
    
    nbtweet=0;
    besthpcnews=[[NSMutableArray alloc] init];
    [myarray=[NSMutableArray alloc] init ];
    
    isHPCnews=YES;
    TwitterConnection *connection= [[TwitterConnection alloc] init];
    connection.delegate=self;
    
    [connection performSearch:@"datanami"];
   
    [connection release];
    
}

-(void)twitterConnection:(TwitterConnection *)connection didReceiveData:(NSData *)data{
 
    // Parsing for TW API 1.0
    //  NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    //   parser.delegate=self;
   //  [parser parse];
   // [parser release];
   //  parser=nil;
    
    
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
        
    NSString *pretmp2=[currentstring replace_em];
        
        // This is disgusting programming. I agree.
        NSString *tmp2=[pretmp2 replace:@"Cloud"];
        tmp2=[tmp2 replaceAT:@"Cloud"];
        tmp2=[tmp2 replaceAT:@"Cloud"];
        tmp2=[tmp2 replace:@"Supercomputer"];
        tmp2=[tmp2 replaceAT:@"Supercomputer"];
        tmp2=[tmp2 replace:@"Supercomputing"];
        tmp2=[tmp2 replaceAT:@"Supercomputing"];
        tmp2=[tmp2 replace:@"HPC"];
        tmp2=[tmp2 replaceAT:@"HPC"];
        tmp2=[tmp2 replace:@"Supercomputing"];
        tmp2=[tmp2 replaceAT:@"Supercomputing"];
        
        
        if (tmp2 != nil) {
            
            NSString *tmp3=[tmp2 removeLink3];
            NSString *tmp=[tmp3 removeLink];
            currentnews.tweet = tmp ;
            currentnews.tweetlink = [tmp3 LinkBD];
            
        }
        
    
        NSString *tmp=[tmp2 removeLink3];
       
     
        currentnews.tweet=[tmp removeLink];
              
        currentnews.tweetlink = [tmp Link];
    
        
       currentnews.tweet = [currentnews.tweet removeRT];
        
        currentnews.tweet = [currentnews.tweet stringByAppendingString:@"via @datanami"];
        
        if(currentnews.tweet==nil || [currentnews.tweet isEqualToString:@""] == TRUE){

            isHPCnews=NO;
            currentnews.tweetlink=nil;
            currentnews.tweet=nil;
        }
        
        currentnews.tweet = [currentnews.tweet removeRT];
    
        currentnews.tweet = [currentnews.tweet stringByAppendingString:@"via @datanami"];
        
        if(currentnews.tweet==nil || [currentnews.tweet isEqualToString:@""] == TRUE  || [currentnews.tweet isEqualToString:@"@< class=\" href=\""] == TRUE){
            isHPCnews=NO;
            currentnews.tweetlink=nil;
            currentnews.tweet=nil;
        }
        
        if (isHPCnews) {
            nbtweet++;
       
              currentnews.tweetlink=[tmp2 LinkBD];
          
            if (currentnews.tweetlink !=nil) {
                
                
                
                [tweetlink_global addObject:currentnews.tweetlink];
                
            }
         
            
             if (currentnews.tweetlink == nil && currentnews.tweet != nil) {
            
                 isHPCnews = NO;
             }
        
        }
        
        
    } else if ([elementName isEqualToString:@"published"]) {
        currentnews.createdAt = currentstring2;
        
    } else if ([elementName isEqualToString:@"feed"]) {
        
        [delegate hpcnewsFinderBData:self didFindHPCNews:[besthpcnews autorelease]];
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

-(NSString*) replaceAT:(NSString*) hashtag {
    
    NSString* myString =  @"@<a class=\" \" href=\"https://twitter.com/wordtoreplace\">wordtoreplace</a>" ;
    
    
    
    NSRange rOriginal = [myString rangeOfString:@"wordtoreplace"];
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
        
        //      NSLog(@"MYSTRING:%@",myString);
        
    }
    
    rOriginal = [myString rangeOfString:@"wordtoreplace"];
    if (NSNotFound != rOriginal.location) {
        myString = [myString
                    stringByReplacingCharactersInRange:rOriginal
                    withString:hashtag];
        
        //     NSLog(@"MYSTRING:%@",myString);
        
    }
    
    
    
    NSArray *words = [self componentsSeparatedByString:myString];
    
    NSMutableString *substring = [[[NSMutableString alloc] init ] autorelease] ;
    
    //int i = [words count] ;
    int j = 0 ;
    
    for (NSString *word in words){
        
        j++;
        
        //   NSLog(@"")
        
        [substring appendString:word];
        
        if (j == 1) {
            
            [substring appendString:hashtag];
            
        }
        
    }
    
    
    return substring;
    
    
}


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

-(NSString*) removeCLASS{
    
    int index = [self rangeOfString:@"<a class=\""].location;
    //  int index2 = [self rangeOfString:@"\">"].location;
    NSString *substring = nil;
    
    //  NSString *mylink = nil;
    
    if (index < self.length){
        
        substring=nil;
        
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
        
    }
    
    rOriginal = [myString rangeOfString:@"wordtoreplace"];
    if (NSNotFound != rOriginal.location) {
        myString = [myString
                    stringByReplacingCharactersInRange:rOriginal
                    withString:hashtag];
        
    }
    
    rOriginal = [myString rangeOfString:@"wordtoreplace"];
    if (NSNotFound != rOriginal.location) {
        myString = [myString
                    stringByReplacingCharactersInRange:rOriginal
                    withString:hashtag];
        
    }
    
    NSArray *words = [self componentsSeparatedByString:myString];
    
    NSMutableString *substring = [[[NSMutableString alloc] init ] autorelease] ;
    
    //int i = [words count] ;
    int j = 0 ;
    
    for (NSString *word in words){
        
        j++;
        
        //   NSLog(@"")
        
        [substring appendString:word];
        
        if (j == 1) {
            
            [substring appendString:hashtag];
            
        }
        
    }
    
    return substring;
    
    
}

-(NSString*) removeRT {
    
    int index = [self rangeOfString:@"RT"].location;
    
    NSString *substring = nil;
    
    if (index == 0) {
        substring = nil ;
    } else {
        substring = self ;
    }
    
    return  substring;
    
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

-(NSString*) replace_em {
    
    NSString* myString = [[[NSString alloc] init] autorelease];
    // [myString initWithString:self] ;
    
    NSArray* foo = [self componentsSeparatedByString:@"<em>"] ;
    NSString* word = nil ;
    // NSString *test = nil ;
    
    for (word in foo) {
        
        
        myString =  [myString stringByAppendingString:word] ;
        
        // NSLog(@"test1:%@",myString);
        
        
    }
    
    return myString;
    
}

-(NSString*) find_link7 {
        
    NSArray* foo = [self componentsSeparatedByString:@" "] ;
       
    int i = [foo count] ;
    int j = i-2 ;
    
    NSString *mylink=nil;
    NSRange start = [self rangeOfString:@"http"];
    NSRange end = [self rangeOfString:[foo objectAtIndex:j]];
    
    if(end.location > start.location && ((end.location-start.location) < 100)) {
            
        mylink= [self substringWithRange:NSMakeRange(start.location, end.location-start.  location)] ;
    
  
        NSArray *foo2 = [mylink componentsSeparatedByString:@" "];
    
        return [foo2 objectAtIndex:0]; 
      
    } else if (end.location == start.location) {
        
        return [foo objectAtIndex:j];
        
            
    } else {
        
        return nil ;
        
    }
}


-(NSString*) LinkBD {
    
    NSString *mylink=nil;
    NSRange start = [self rangeOfString:@"<a href=\""];
  //  NSRange end = [self rangeOfString:@"\">"];
     NSRange end = [self rangeOfString:@"\" class"];
    
    if (start.location < self.length) {
        mylink= [self substringWithRange:NSMakeRange(start.location+9, end.location-start.location-9)];
              
        
    }
     
    return mylink;
    
}

@end
