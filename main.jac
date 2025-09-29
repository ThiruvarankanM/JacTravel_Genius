import from byllm { Model }

glob llm = Model(model_name="gemini/gemini-2.5-flash");

enum Budget {
    BUDGET,
    MODERATE,
    LUXURY
}

obj Activity {
    has name: str;
    has description: str;
    has duration_hours: float;
    has cost: float;
    has time: str;
}

obj DayPlan {
    has day: int;
    has activities: list[Activity];
    has total_cost: float;
}

obj TravelPlan {
    has destination: str;
    has days: int;
    has budget: Budget;
    has daily_plans: list[DayPlan];
    has tips: list[str];
    has total_cost: float;
}

sem TravelPlan = "Complete travel itinerary. MUST use destination's local currency code (LKR for Sri Lanka, JPY for Japan, EUR for Europe, INR for India etc.) NOT USD. Use realistic local market prices";
sem DayPlan = "Activities planned for a single day";
sem Activity = "Activity with timing and cost in destination's local currency (NOT USD)";

def create_itinerary(destination: str, days: int, budget: Budget, interests: str) -> TravelPlan by llm(method="Reason");

node PlanNode {
    has travel_plan: TravelPlan;
    
    def show() {
        plan = self.travel_plan;
        print(f"\n✈️  TRAVEL PLAN: {plan.destination}");
        print(f"📅 Duration: {plan.days} days | 💰 Budget: {plan.budget}");
        print(f"💵 Total Cost: ${plan.total_cost}");
        
        for day_plan in plan.daily_plans {
            print(f"Day {day_plan.day} (${day_plan.total_cost}):");
            for activity in day_plan.activities {
                print(f"  {activity.time} - {activity.name} (${activity.cost})");
                print(f"    {activity.description}");
            }
            print();
        }
        
        print("💡 Tips:");
        for tip in plan.tips {
            print(f"  • {tip}");
        }
    }
}

walker TravelPlanner {
    has destination: str;
    has days: int;
    has budget: Budget;
    has interests: str;
    
    can start with `root entry {
        print("🌍 Creating your travel itinerary...\n");
        
        plan = create_itinerary(self.destination, self.days, self.budget, self.interests);
        
        plan_node = PlanNode(travel_plan=plan);
        visit plan_node;
    }
    
    can display with PlanNode entry {
        here.show();
    }
}

with entry {
    city = input("Destination: ");
    days = int(input("Days: "));
    
    print("Budget: 1=Budget, 2=Moderate, 3=Luxury");
    budget_choice = int(input("Choice: "));
    budget = [Budget.BUDGET, Budget.MODERATE, Budget.LUXURY][budget_choice - 1];
    
    interests = input("Interests: ");
    
    planner = TravelPlanner(
        destination=city,
        days=days,
        budget=budget,
        interests=interests
    ) spawn root;
}