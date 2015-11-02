//
//  ViewController.m
//  HpplyTest0901
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLConnectionDataDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TFHpple *doc = [[TFHpple alloc] initWithHTMLData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.qiushibaike.com"]] encoding:@"utf-8"];
    
    NSArray *elements = [doc searchWithXPathQuery:@"//div[@class='article block untagged mb15']"];
    
          for (TFHppleElement *elmt in elements)
    {
     //   NSArray *elements1 = [elmt searchWithXPathQuery:@"//div[@class='content']"];
      //  NSLog(@"content:%@",[[elements1 firstObject] content]);
        NSArray *elements2 = [elmt searchWithXPathQuery:@"//div[@class='thumb']/a/img"];
        TFHppleElement *aa = [elements2 firstObject];
        NSDictionary *dic = [aa attributes];
        NSLog(@"content:%@",[dic objectForKey:@"src"]);
       
        NSURL *url = [NSURL URLWithString:[dic objectForKey:@"src"]];
            NSMutableURLRequest *re = [NSMutableURLRequest requestWithURL:url];
            
            [NSURLConnection sendAsynchronousRequest:re queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
                [data writeToFile:@"Users/apple/Desktop/101.png" atomically:YES];
                   }];
        }
    }
    
    
    
    


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end


