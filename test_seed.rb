require 'byebug'

$possible_notes = ["c", "d", "e", "f", "g", "a", "b", "c4"]

# possible_patterns = []
neg_patterns = []
pos_patterns = []


pos_patterns << [1, 1, 1, 1]
neg_patterns << [-1, -1, -1, -1]
new_pos = []
new_neg = []

4.times do |i|
    new_pattern = pos_patterns[0].clone
    # byebug
    new_pattern[i] = -new_pattern[i]
    new_pos << new_pattern
    puts new_pos
end
4.times do |i|
    new_pattern = neg_patterns[0].clone
    new_pattern[i] = -new_pattern[i]
    new_neg << new_pattern
end
puts "step 1"

pos_patterns = pos_patterns.concat(new_pos)
neg_patterns = neg_patterns.concat(new_neg)

# byebug
temp_pos = pos_patterns.clone
temp_neg = neg_patterns.clone
new_pos = []
new_neg = []

[2, 3, 4, 5].each do |e1|
    temp_pos.each do |e2|
        new_pattern = e2.clone
        4.times do |i|
            new_pattern_2 = new_pattern.clone 
            new_pattern_2[i] = e1.clone
            new_pos << new_pattern_2
            puts new_pos.length
        end
    end
    temp_neg.each do |e2|
        new_pattern = e2.clone
        4.times do |i| 
            new_pattern_2 = new_pattern.clone
            new_pattern_2[i] = e1.clone
            new_neg << new_pattern
            puts new_neg.length
        end
    end
end
puts "step 2"
# byebug

pos_patterns = temp_pos.concat(new_pos)
neg_patterns = temp_neg.concat(new_neg)

temp_pos = pos_patterns
temp_neg = neg_patterns
new_pos = []
new_neg = []

[2, 3].each do |e1|
    temp_pos.each do |e2|
        new_pattern = e2.clone
        new_pattern2 = e2.clone
        4.times do |i|
            new_pattern_2 = new_pattern.clone
            new_pattern_22 = new_pattern2.clone
            new_pattern_2[i] = e1.clone
            new_pattern_22[i] = -e1.clone
            new_pos << new_pattern_2
            new_pos << new_pattern_22
        end
    end
    temp_neg.each do |e2|
        new_pattern = e2.clone
        new_pattern2 = e2.clone
        4.times do |i|
            new_pattern_2 = new_pattern.clone
            new_pattern_22 = new_pattern2.clone
            new_pattern_2[i] = e1.clone
            new_pattern_22[i] = -e1.clone
            new_neg << new_pattern_2
            new_neg << new_pattern_22
        end
    end
end
puts "step 3"

# byebug

pos_patterns = temp_pos.concat(new_pos)
neg_patterns = temp_neg.concat(new_neg)

possible_patterns =  pos_patterns.concat(neg_patterns)
# byebug
g4l10 = []

def figure_it_out(starting_index, ar)
    new_ar = []
    new_ar[0] = starting_index
    x = 1
    while x<=ar.length
         new_ar[x] = new_ar[x-1] + ar[x-1]
         if (new_ar[x] < 0) || (new_ar[x] >= 8 )
            return nil
         end
         x += 1
        #  puts x
    end
    # byebug
    return new_ar.map{|e1| $possible_notes[e1]}
end

puts "step 4"

possible_patterns.each do |e1|    
    y = 0
    while y < 8
        g4l10 << figure_it_out(y, e1)
        y += 1
    end
    puts "finished loop #{e1}"
end

puts (g4l10.reject{|h| h==nil})
puts (g4l10.reject{|h| h==nil}).length

byebug
0














game1 = Game.create(name: "Note Names and Sequences", order_matters: true, intro_message: "Please play the note or notes that I say in order", list_note_names: true, either_c: false)

### Level 1: Low and High Do
g1l1 = [[c], [c4]]

### Level 2: Add Sol
g1l2 = [[g], [g], [c], [c4], [g]]
### Level 3: Add Mi
g1l3 = [[e], [e], [e], [g], [c], [c4]]
### Level 4: Same notes (2 note sequences)
g1l4 = []
[c,c4,e, g].each {|e1| [c,c4,e, g].each {|e2| g1l4 << [e1,e2]}}
### Level 5: Add Re (2 notes)
g1l5 = []
[c,c4,e,g].each do |e1| 
    g1l5 << [e1, d]
    g1l5 << [d, e1]
end  
g1l5 << [d,d]
### Level 6: Same notes (3 note sequences)
g1l6 = []
[c,c4,e, g, d].each {|e1| [c,c4,e, g, d].each {|e2| [c,c4,e,g,d].each {|e3| g1l6 << [e1,e2, e3]}}}
### Level 7: Add La (2 notes)
g1l7 = []
[c,c4,e,g, d].each do |e1| 
    g1l7 << [e1, a]
    g1l7 << [a, e1]
end
g1l7 << [a,a]
### Level 8: Add Fa (2 notes)
g1l8 = []
[c,c4,e,g, d, a].each do |e1| 
    g1l8 << [e1, f]
    g1l8 << [f, e1]
end
g1l8 << [f,f]
### Level 9: Add Ti (2 notes)
g1l9 = []
[c,c4,e,g, d, a, f].each do |e1| 
    g1l9 << [e1, b]
    g1l9 << [b, e1]
end
g1l9 << [b, b]
### Level 10: All Notes (3 note patterns)
g1l10 = []
[c,c4,e, g, d, a, f, b].each {|e1| [c,c4,e, g, d, a, f, b].each {|e2| [c,c4,e,g,d, a, f, b].each {|e3| g1l10 << [e1,e2, e3]}}}
### Level 11: All Notes (4 note patterns)
g1l11 = []
[c,c4,e, g, d, a, f, b].each {|e1| [c,c4,e, g, d, a, f, b].each {|e2| [c,c4,e,g,d, a, f, b].each {|e3| [c,c4,e,g,d, a, f, b].each {|e4| g1l11 << [e1,e2, e3, e4]}}}}

g1messages = [
    "Can you tell the difference between high Do (C) and low Do (C)?",
    "Now, we're going to add in Sol (G)!",
    "Now, we're going to add in Mi (E)!",
    "Now, I'm going to ask you to play two notes in a row!",
    "Now, we'll add in Re (D)!",
    "Let's try some 3 note sequences with Do, Re, Mi, and So!",
    "Now, we'll add in in La (A)!",
    "Now, we'll add in Fa (F)!",
    "We'll at in Ti (B) this time to finish our full scale!",
    "Now, I'm going to ask you to play 3 notes in a row from full scale!",
    "Finally, I'm going to you ask you to play 4 notes in a row from the full scale!"
].cycle

g1demo_notes = [
    "C4:C3", "G3", "E3","C3:D3:E3:G3", "D3", "", "A3", "F3", "B3","C3:D3:E3:F3:G3:A3:B3:C4","C3:D3:E3:F3:G3:A3:B3:C4"
].cycle

[g1l1, g1l2, g1l3, g1l4, g1l5, g1l6, g1l7, g1l8, g1l9, g1l10, g1l11].each_with_index do |level, i|
    lev = Level.create(level_num: i+1, level_message: g1messages.next, game: game1, demo_notes: g1demo_notes.next)
    # game1.levels << lev
    level.each do |question|
        questionString = question.map{|n| n.pitch_name}.join(', ') # is this going to create extra commas?
        quest1 = Question.create(level: lev, question_text: "#{question.length<=1 ? 'Play a ' : 'Play these notes in order: '}#{questionString}!", use_solfege: false)
        # debugger
        quest1.assign_notes(question)
        # lev.questions << quest1
        questionString = question.map{|n| n.solfege_value}.join(', ') # is this going to create extra commas?
        quest2 = Question.create(level: lev, question_text: "#{question.length<=1 ? 'Play a ' : 'Please these notes in order: '}#{questionString}!")
        quest2.assign_notes(question)
        # lev.questions << quest2
    end
end