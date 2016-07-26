//
//  SettingsTableViewController.m
//  iPokeGo
//
//  Created by Dimitri Dessus on 21/07/2016.
//  Copyright © 2016 Dimitri Dessus. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "PokemonSelectTableViewController.h"

@interface SettingsTableViewController ()

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self readSavedState];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)readSavedState
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    self.serverField.text = [prefs valueForKey:@"server_addr"];
    
    if([prefs objectForKey:@"display_pokemons"] == nil)
        [self.pokemonsSwitch setOn:YES]; // Not already set
    else
        [self.pokemonsSwitch setOn:[prefs boolForKey:@"display_pokemons"]];
    
    if([prefs objectForKey:@"display_pokestops"] == nil)
        [self.pokestopsSwitch setOn:NO]; // Not already set
    else
        [self.pokestopsSwitch setOn:[prefs boolForKey:@"display_pokestops"]];
    
    if([prefs objectForKey:@"display_gyms"] == nil)
        [self.gymsSwitch setOn:YES]; // Not already set
    else
        [self.gymsSwitch setOn:[prefs boolForKey:@"display_gyms"]];
    
    if([prefs objectForKey:@"display_common"] == nil)
        [self.commonSwitch setOn:NO]; // Not already set
    else
        [self.commonSwitch setOn:[prefs boolForKey:@"display_common"]];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if([segue.identifier isEqualToString:@"showPokemonSelect"]) {
		PokemonSelectTableViewController *destViewController = segue.destinationViewController;

		switch (((UITableViewCell *)sender).tag) {
			case SELECT_COMMON:
				destViewController.title = @"Common";
				destViewController.preferenceKey = @"pokemon_common";
				break;
			case SELECT_FAVORITE:
				destViewController.title = @"Favorite";
				destViewController.preferenceKey = @"pokemon_favorite";
				break;
			default:
				break;
		}
	}
}

-(IBAction)closeAction:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [[NSNotificationCenter defaultCenter]
                                    postNotificationName:@"HideRefresh"
                                    object:nil
                                    userInfo:nil];
}

-(IBAction)saveAction:(UIBarButtonItem *)sender
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if([self.serverField.text length] > 0)
    {
        [prefs setObject:self.serverField.text forKey:@"server_addr"];
    }
    
    [prefs synchronize];
    
    [[NSNotificationCenter defaultCenter]
                                    postNotificationName:@"HideRefresh"
                                    object:nil
                                    userInfo:nil];
    
    [[NSNotificationCenter defaultCenter]
                                    postNotificationName:@"LoadSaveData"
                                    object:nil
                                    userInfo:nil];
    
    [[NSNotificationCenter defaultCenter]
                                    postNotificationName:@"LaunchTimers"
                                    object:nil
                                    userInfo:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)swicthsAction:(UISwitch *)sender
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    switch (sender.tag) {
        case SWITCH_POKEMON:
            [prefs setObject:[NSNumber numberWithBool:self.pokemonsSwitch.on] forKey:@"display_pokemons"];
            break;
        case SWITCH_POKESTOPS:
            [prefs setObject:[NSNumber numberWithBool:self.pokestopsSwitch.on] forKey:@"display_pokestops"];
            break;
        case SWITCH_GYMS:
            [prefs setObject:[NSNumber numberWithBool:self.gymsSwitch.on] forKey:@"display_gyms"];
            break;
        case SWITCH_COMMON:
            [prefs setObject:[NSNumber numberWithBool:self.commonSwitch.on] forKey:@"display_common"];
            break;
            
        default:
            // Nothing
            break;
    }
    
    [prefs synchronize];
}

@end
