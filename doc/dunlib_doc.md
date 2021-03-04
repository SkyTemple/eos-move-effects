# Terminology

### Function Parameters

See "global_doc.md" for more information.

### User and Target

Pointers to a dungeon RAM monster structure (one for the user of the move and one for the target; if the move hits multiple targets the code will be executed for each target).

Most of the time the User is only used to display messages (see Message functions); by convention, always pass the current user of the move as the User.

If you want to apply an effect to the current user, pass the current user as the Target of the effect.

See UsernameFodder's RAM notes about entity data block offsets: https://docs.google.com/document/d/1_Q_7BGmNx5wJtJ9iJEwlK1WITjiCcEQxE9C82RECJbg/edit


### StatType

The type of stat that will be affected by the function.
- for Attack & Defense functions: 0 = Normal, 1 = Special
- for Focus functions: 0 = Accuracy, 1 = Evasiveness

### MoveData

MoveData is a pointer to an 8 bytes RAM structure composed of the following elements: 
- flags (4 bytes)
- move_id (2 bytes)
- pp_left (1 byte)
- boost (1 byte)

### FailMessage

FailMessage indicates that the function must not send any message to the dungeon console or the console if the effect was prevented.
For example, if this is set to 0 for the Poison function, the game will not send the message saying that the Pecha Scarf prevented poisoning.

# Structures

### DungeonBaseStructure

Accessible via DungeonBaseStructurePtr

Contains all the information about the current dungeon

See UsernameFodder's RAM notes about base pointers: https://docs.google.com/document/d/1_Q_7BGmNx5wJtJ9iJEwlK1WITjiCcEQxE9C82RECJbg/edit

# Functions

## Experience

### AddExp(r0: User, r1: Target, r2: ExpGain)

## Damage

### ConstDamage(r0: Target, r1: Damage, r2: ???, r3: ???, [r13]: MoveID, [r13+0x4]: ???, [r13+0x8]: ???, [r13+0xC]: MessageType, [r13+0x10]: ???, [r13+0x14]: ???)

9999 damage is considered as calamitous

## Heal

### HealAllMovesPP(r0: User, r1: Target, r2: PPHeal, r3: NoMessage)

### r0: Success = RaiseHP(r0: User, r1: Target, r2: HPHeal, r3: MaxHPRaise, [r13]: FailMessage)

## Status Effects

### SleepSingle(r0: Target, r1: NbTurns)

Don't use this, use Sleep instead.

### Sleep(r0: User, r1: Target, r2: NbTurns, r3: FailMessage)

### Nightmare(r0: User, r1: Target, r2: NbTurns)

### Rest(r0: User, r1: Target, r2: NbTurns)

### Yawn(r0: User, r1: Target, r2: NbTurns)

### Sleepless(r0: User, r1: Target)

### r0: CanInflict = Pause(r0: User, r1: Target, r2: ???, r3: NbTurns, [r13]: FailMessage, [r13+0x4]: OnlyCheck)

### r0: CanInflict = Infatuate(r0: User, r1: Target, r2: FailMessage, r3: OnlyCheck)

### r0: CanInflict = Burn(r0: User, r1: Target, r2: SpecialEffect, r3: FailMessage, [r13]: OnlyCheck)

### AllTeamBurn()

### r0: CanInflict = Poison(r0: User, r1: Target, r2: FailMessage r3: OnlyCheck)

### r0: CanInflict = BadPoison(r0: User, r1: Target, r2: FailMessage, r3: OnlyCheck)

### Freeze(r0: User, r1: Target, r2: FailMessage)

### Constrict(r0: User, r1: Target, r2: ???, r3: FailMessage)

### Immobilize(r0: User, r1: Target, r2: FailMessage)

### Root(r0: User, r1: Target)

### Wrap(r0: User, r1: Target)

### Petrify(r0: User, r1: Target)

### AttackStatDown(r0: User, r1: Target, r2: StatType, r3: NbStages, [r13]: ???, [r13+0x4]: ???)
### DefenseStatDown(r0: User, r1: Target, r2: StatType, r3: NbStages, [r13]: ???, [r13+0x4]: ???)
### AttackStatUp(r0: User, r1: Target, r2: StatType, r3: NbStages, [r13]: ???, [r13+0x4]: ???)
### DefenseStatUp(r0: User, r1: Target, r2: StatType, r3: NbStages, [r13]: ???, [r13+0x4]: ???)

### AttackStatMinMax(r0: User, r1: Target, r2: StatType, r3: StatChange, [r13]: ???)
### DefenseStatMinMax(r0: User, r1: Target, r2: StatType, r3: StatChange, [r13]: ???)
### FocusStatUp(r0: User, r1: Target, r2: StatType)
### FocusStatDown(r0: User, r1: Target, r2: StatType)

### r0: CanInflict = Cringe(r0: User, r1: Target, r2: FailMessage, r3: OnlyCheck)

### r0: CanInflict = Paralyse(r0: User, r1: Target, r2: FailMessage, r3: OnlyCheck)

### r0: HasEffect = CheckAdditionalEffect(r0: Target, r1: EffectID)

Returns 0 if it hasn't this additional effect or any other value if it has.

### SpeedStatUp(r0: User, r1: Target, r2: NbStages, r3: NbTurns, [r13]: FailMessage)

### SpeedStatUpOneStage(r0: User, r1: Target, r2: NbTurns, r3: FailMessage)

Calls SpeedStatUp passing 1 to r2, r2 to r3 and r3 to \[r13\].

### SpeedStatDown(r0: User, r1: Target, r2: NbStages, r3: FailMessage)

### SealMove(r0: User, r1: Target, r2: FailMessage)

### RandomSpeedUpDown(r0: User, r1: Target)

Randomly increases or decreases speed by one stage (50/50).

### ResetFocusStat(r0: User, r1: Target, r2: StatType, r3: ???)

### r0: CanInflict = Confuse(r0: User, r1: Target, r2: FailMessage, r3: OnlyCheck)

### r0: CanInflict = Fear(r0: User, r1: Target, r2: FailMessage, r3: OnlyCheck)

### r0: CanInflict = SelfPoison(r0: User, r1: Target, r2: FailMessage, r3: OnlyCheck)

Inflicts Poison status to the User, not the Target.

### DestinyBond(r0: User, r1: Target)

## Random Utils

### r0: Success = RandomChanceUT(r0: User, r1: Target, r2: Chance)

Chance is a chance between 0 and 100.

Success returns 0 if it doesn't pass the chance or any other value if it passes.

Always returns 0 if the User or the Target fainted.

### r0: Success = RandomChanceU(r0: User, r1: Chance)

Chance is a chance between 0 and 100. A 0 Chance is considered as a sure success.

Success returns 0 if it doesn't pass the chance or any other value if it passes.

Always returns 0 if the User fainted.

## Complex Effects

### DamageWithRecoil(r0: User, r1: Target, r2: MoveData, r3: ItemID)

### r0: Damaged = DealDamage(r0: User, r1: Target, r2: MoveData, r3: DamageMultiplier, [r13]: ItemID)

0x100 is the normal multiplier

Damaged returns a non-zero value when the target was damaged.

In fact, it returns the damage dealt to the target.

## Getters

### r0: WeatherID = GetWeather(r0: Target)

Gets the current weather for the selected target. 

Applies target's effects that neutralize weather conditions.

## Messages

### ChangeString(r0: StringID, r1: Target, r2: ???)

Replaces the string at StringID by the string representation of the Target (aka its name)

Any message with the string manipulator "\[string:StringID\]" will use that string

Note: r2 seems to always be 0 

### SendMessageWithIDCheckULog(r0: User, r1: MessageID)

Checks if the User fainted.

If it hasn't, calls SendMessageWithID with Log set to 1.

### SendMessageWithStringCheckULog(r0: User, r1: StringPointer)

Checks if the User fainted.

If it hasn't, calls SendMessageWithString with Log set to 1.

### SendMessageWithIDNoLog(r0: User, r1: MessageID)

Same as SendMessageWithID but sets Log to 0.

### SendMessageWithStringNoLog(r0: User, r1: StringPointer)

Same as SendMessageWithString but sets Log to 0.

### SendMessageWithIDCheckUTLog(r0: User, r1: Target, r2: MessageID)

Checks something with the User or the Target fainted.

If they haven't, calls SendMessageWithID with Log set to 1.

### SendMessageWithStringCheckUTLog(r0: User, r1: Target, r2: StringPointer)

Checks something with the User or the Target fainted.

If they haven't, calls SendMessageWithString with Log set to 1.

### SendMessageWithIDCheckUTNoLog(r0: User, r1: Target, r2: MessageID)

Checks something with the User or the Target fainted.

If they haven't, calls SendMessageWithID with Log set to 0.

### SendMessageWithIDCheckUULog(r0: User, r1: ???, r2: MessageID)

Checks if the User fainted and something else with an unknown structure.

If the User hasn't fainted, and if the other check passes, calls SendMessageWithID with Log set to 1.

WARNING! Deprecated: function name may change

### SendMessageWithIDLog(r0: User, r1: MessageID)

Same as SendMessageWithID but sets Log to 1.

### SendMessageWithStringLog(r0: User, r1: MessageID)

Same as SendMessageWithString but sets Log to 1.

### SendMessageWithString(r0: User, r1: StringPointer, r2: Log)

Sends a message to the dungeon console (the one that appears in the lower part 
of the screen) and in the message log.

Use the string pointed at StringPointer.

The User is used to determine if the message is in the same turn as the previous one, in order to separate them with a horizontal bar.

If Log is set to 0, the message will only appear in the message log.

### SendMessageWithID(r0: User, r1: MessageID, r2: Log)

Same as SendMessageWithString, but uses a string defined in the ".str" file at index MessageID.

