//
//  DimMyScene.m
//  Dimensional
//
//  Created by Iggy Krajci on 9/21/13.
//  Copyright (c) 2013 Iggy Krajci. All rights reserved.
//

#import "DimMyScene.h"


@interface DimMyScene ()

@property (nonatomic) SKSpriteNode * player;
@property (nonatomic) SKNode * world;
@property (nonatomic) SKPhysicsBody * worldEdges;

@end

@implementation DimMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        self.anchorPoint = CGPointMake (0.5,0.5);
        
        self.world = [SKNode node];
//        [self addChild:self.world];
        
        SKLabelNode * camera = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        camera.text = @"camera";
        camera.name = @"camera";
        [self.world addChild:camera];
        
        SKLabelNode * myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Hello, World!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        [self.world addChild:myLabel];
        
        self.player = [SKSpriteNode spriteNodeWithImageNamed:@"blue_circle"];
        self.player.position = CGPointMake(100, 100);
        self.player.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.player.size.width/2];
        self.player.physicsBody.friction = 0;
        
//        SKPhysicsBody *worldEdges = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 9000, self.frame.size.height)];
//        CG
//        self.worldEdges = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.worldEdges = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, -160, 9000, self.frame.size.height)];

        NSLog(@"Width %f", self.frame.size.width);
        NSLog(@"Height %f", self.frame.size.height);

        self.world.physicsBody = self.worldEdges;
        self.world.position = CGPointMake(0,0);
        self.player.physicsBody.velocity = CGVectorMake(50, 0);

        [self addChild:self.world];

        [self.world addChild:self.player];

    }
    return self;
}



- (void)didSimulatePhysics {
    [self centerOnNode: [self childNodeWithName: @"//camera"]];
    SKNode * camera = [self childNodeWithName: @"//camera"];
    camera.position = CGPointMake(self.player.position.x, camera.position.y);
//    camera.position = self.player.position;
    
//    self.player.physicsBody.velocity = CGVectorMake(50, 0);
    

}
- (void) centerOnNode: (SKNode*) node
{
    CGPoint cameraPositionInScene = [node.scene convertPoint:node.position
                                                    fromNode:node.parent];
    node.parent.position = CGPointMake(node.parent.position.x -
                                       cameraPositionInScene.x,
                                       node.parent.position.y - cameraPositionInScene.y);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//        
//        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
//        
//        sprite.position = location;
//        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
//        
//        [sprite runAction:[SKAction repeatActionForever:action]];
//        
//        [self addChild:sprite];
        self.player.physicsBody.velocity = CGVectorMake(self.player.physicsBody.velocity.dx+50, self.player.physicsBody.velocity.dy+100);

    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
